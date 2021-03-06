/* Haxe XPath by Daniel J. Cassidy <mail@danielcassidy.me.uk>
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


package xpath.library;
import haxe.unit.TestCase;
import xpath.library.BooleanLibrary;
import xpath.context.FakeContext;
import xpath.value.XPathBoolean;
import xpath.value.XPathValue;
import xpath.EvaluationException;


class BooleanLibraryTest extends TestCase {
    function testNot() {
        var xTrue:XPathValue = new XPathBoolean(true);
        assertFalse(BooleanLibrary.not(new FakeContext(), [ xTrue ]).getBool());

        var xFalse:XPathValue = new XPathBoolean(false);
        assertTrue(BooleanLibrary.not(new FakeContext(), [ xFalse ]).getBool());

        var caught = false;
        try {
            BooleanLibrary.not(new FakeContext(), []);
        } catch (exception:EvaluationException) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            BooleanLibrary.not(new FakeContext(), [ xTrue, xFalse ]);
        } catch (exception:EvaluationException) {
            caught = true;
        }
        assertTrue(caught);
    }

    function testTrue() {
        assertTrue(BooleanLibrary.getTrue(new FakeContext(), []).getBool());

        var caught = false;
        try {
            var xTrue:XPathValue = new XPathBoolean(true);
            BooleanLibrary.getTrue(new FakeContext(), [ xTrue ]);
        } catch (exception:EvaluationException) {
            caught = true;
        }
        assertTrue(caught);
    }

    function testFalse() {
        assertFalse(BooleanLibrary.getFalse(new FakeContext(), []).getBool());

        var caught = false;
        try {
            var xTrue:XPathValue = new XPathBoolean(true);
            BooleanLibrary.getFalse(new FakeContext(), [ xTrue ]);
        } catch (exception:EvaluationException) {
            caught = true;
        }
        assertTrue(caught);
    }
}
