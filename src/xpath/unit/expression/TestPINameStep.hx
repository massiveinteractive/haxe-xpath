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


package xpath.unit.expression;
import haxe.unit.TestCase;
import dcxml.Xml;
import xpath.expression.PINameStep;
import xpath.context.Context;
import xpath.context.Environment;
import xpath.context.DynamicEnvironment;
import xpath.type.XPathValue;
import xpath.type.XPathNodeSet;


class TestPINameStep extends TestCase {
	
	private var environment:Environment;
	
	
	public function new () {
		super();
		environment = new DynamicEnvironment();
	}
	
	private function testPINameStep () {
		var element:Xml = Xml.createElement("foo");
		var processingInstruction:Xml = Xml.createProcessingInstruction("foo", "bar");
		element.setAttributeValue("foo", "bar");
		var attribute:Xml = element.getAttribute("foo");
		
		var pINameStep:PINameStep = new PINameStep("foo");
		var result:XPathValue = pINameStep.evaluate(new Context(element, 1, 1, environment));
		var nodes:Array<Xml> = cast(result, XPathNodeSet).getNodes();
		assertEquals(0, nodes.length);
		
		result = pINameStep.evaluate(new Context(processingInstruction, 1, 1, environment));
		nodes = cast(result, XPathNodeSet).getNodes();
		assertEquals(processingInstruction, nodes[0]);
		
		result = pINameStep.evaluate(new Context(attribute, 1, 1, environment));
		nodes = cast(result, XPathNodeSet).getNodes();
		assertEquals(0, nodes.length);
		
		processingInstruction = Xml.createProcessingInstruction("bat", "baz");
		result = pINameStep.evaluate(new Context(processingInstruction, 1, 1, environment));
		nodes = cast(result, XPathNodeSet).getNodes();
		assertEquals(0, nodes.length);
		
		pINameStep = new PINameStep();
		result = pINameStep.evaluate(new Context(element, 1, 1, environment));
		nodes = cast(result, XPathNodeSet).getNodes();
		assertEquals(0, nodes.length);
		
		result = pINameStep.evaluate(new Context(processingInstruction, 1, 1, environment));
		nodes = cast(result, XPathNodeSet).getNodes();
		assertEquals(processingInstruction, nodes[0]);
		
		result = pINameStep.evaluate(new Context(attribute, 1, 1, environment));
		nodes = cast(result, XPathNodeSet).getNodes();
		assertEquals(0, nodes.length);
	}
	
}