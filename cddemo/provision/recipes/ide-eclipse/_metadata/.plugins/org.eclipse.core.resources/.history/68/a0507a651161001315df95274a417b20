package net.pingworks.example.musicDB.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.management.ImmutableDescriptor;

import net.pingworks.example.musicDB.bo.AlbumBO;

@ManagedBean
@ApplicationScoped
public class AlbumRepository {

	private long uniqueId = 1;

	private Map<Long, AlbumBO> albumMap = new HashMap<Long, AlbumBO>();

	public AlbumRepository() throws Exception {
		super();
		init();
	}

	public void init() throws Exception {
		albumMap = new HashMap<Long, AlbumBO>();
		AlbumBO bo;

		bo = new AlbumBO();
		bo.setArtist("Fritz Kalkbrenner");
		bo.setTitle("Here Today Gone Tomorrow");
		persist(bo);

		bo = new AlbumBO();
		bo.setArtist("Fritz Kalkbrenner");
		bo.setTitle("Sick Travelin´");
		persist(bo);

		bo = new AlbumBO();
		bo.setArtist("Keith Jarrett");
		bo.setTitle("The Koeln Concert");
		persist(bo);

		bo = new AlbumBO();
		bo.setArtist("Keith Jarrett");
		bo.setTitle("Rio");
		persist(bo);

		bo = new AlbumBO();
		bo.setArtist("Moloko");
		bo.setTitle("Things to make and do");
		persist(bo);

		bo = new AlbumBO();
		bo.setArtist("LaBrassBanda");
		bo.setTitle("Ubersee");
		persist(bo);
	}

	private long getUniqueId() throws Exception {
		long id;
		for (int i = 0; i < 10000; i++) {
			id = uniqueId++;
			if (!albumMap.containsKey(id))
				return id;
		}
		throw new Exception("No unique id found.");
	}

	public List<AlbumBO> getList() {
		return new ArrayList<AlbumBO>(albumMap.values());
	}

	public void persist(AlbumBO album) throws Exception {
		if (album.getId() == 0L) {
			album.setId(getUniqueId());
		}
		albumMap.put(album.getId(), album);
		System.out.println("Saved: " + album.getId());
		System.out.println("Repo size: " + albumMap.size());
	}

	public void delete(AlbumBO album) {
		albumMap.remove(album.getId());
		System.out.println("Deleted: " + album.getId());
		System.out.println("Repo size: " + albumMap.size());
	}
	
}
