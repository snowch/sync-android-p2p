import static org.junit.Assert.fail;

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import com.cloudant.sync.datastore.Datastore;
import com.cloudant.sync.datastore.DatastoreManager;
import com.cloudant.sync.datastore.DocumentBodyFactory;
import com.cloudant.sync.datastore.MutableDocumentRevision;
import com.cloudant.sync.replication.Replicator;
import com.cloudant.sync.replication.ReplicatorBuilder;


public class P2PTest extends P2PAbstractTest {

	
	@Before
	public void setup() throws Exception {
		createServer(8182);
		createServer(8184);
	}
	
	@Test
	public void test() throws Exception {

		try {
			URI uri = new URI("http://localhost:8183/mydb");
	
			DatastoreManager manager = new DatastoreManager(databaseDirs.get(8182));
			Datastore ds = manager.openDatastore("mydb");
	
	
			MutableDocumentRevision rev = new MutableDocumentRevision();
			Map<String, Object> json = new HashMap<String, Object>();
			json.put("description", "Buy milk");
			json.put("completed", false);
			json.put("type", "com.cloudant.sync.example.task");
			rev.body = DocumentBodyFactory.create(json);
			ds.createDocumentFromRevision(rev);
	
			Replicator replicator = ReplicatorBuilder.push().from(ds).to(uri).build();
			waitForReplication(replicator);
		}
		catch (Exception e) {
			fail("Unexpected exception: " + e.getMessage());
		}
	}
}
