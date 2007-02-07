/* haXe XPath by Daniel J. Cassidy <mail@danielcassidy.me.uk>
 * Dedicated to the Public Domain
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS 
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */


package xpath.unit.tokenizer.util;
import haxe.unit.TestCase;
import xpath.unit.tokenizer.util._TestUtil;
import xpath.tokenizer.util.Repetition;
import xpath.tokenizer.Tokenizer;
import xpath.tokenizer.TokenizeState;


class TestRepetition extends TestCase {
	
	public function testAll () {
		var state:TokenizeState = new TokenizeState("    ");
		
		var tokenizer:Tokenizer = new Repetition([
			cast(new AnyCharTokenizer(), Tokenizer), new AnyCharTokenizer()
		]);
		var resultState:TokenizeState = tokenizer.tokenize(state);
		assertEquals(4, resultState.pos);
		assertEquals(4, resultState.result.length);
		
		var tokenizer = new Repetition([
			cast(new AnyCharTokenizer(), Tokenizer), new AnyCharTokenizer(),
			new AnyCharTokenizer(), new AnyCharTokenizer()
		]);
		resultState = tokenizer.tokenize(state);
		assertEquals(4, resultState.pos);
		assertEquals(4, resultState.result.length);
		
		tokenizer = new Repetition([
			cast(new NeverTokenizer(), Tokenizer), new AnyCharTokenizer()
		]);
		resultState = tokenizer.tokenize(state);
		assertEquals(0, resultState.pos);
		assertEquals(0, resultState.result.length);
		
		tokenizer = new Repetition([
			cast(new AnyCharTokenizer(), Tokenizer), new NeverTokenizer()
		]);
		resultState = tokenizer.tokenize(state);
		assertEquals(0, resultState.pos);
		assertEquals(0, resultState.result.length);
		
		tokenizer = new Repetition([
			cast(new AnyCharTokenizer(), Tokenizer), new AnyCharTokenizer(),
			new AnyCharTokenizer(), new NeverTokenizer()
		]);
		resultState = tokenizer.tokenize(state);
		assertEquals(0, resultState.pos);
		assertEquals(0, resultState.result.length);
	}
	
}
