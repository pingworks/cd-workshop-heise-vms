package net.pingworks.example.musicDB.service;

import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ApplicationScoped;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;

import net.pingworks.example.musicDB.bo.AlbumBO;
import net.pingworks.example.musicDB.dto.AlbumDTO;
import net.pingworks.example.musicDB.repository.AlbumRepository;

@ManagedBean
@ApplicationScoped
public class AlbumService {

	@ManagedProperty(value="#{albumConverter}")
	private AlbumConverter converter;
	
	@ManagedProperty(value="#{albumRepository}")
	private AlbumRepository repo;
	
	public AlbumConverter getConverter() {
		return converter;
	}

	public void setConverter(AlbumConverter converter) {
		this.converter = converter;
	}

	public AlbumRepository getRepo() {
		return repo;
	}

	public void setRepo(AlbumRepository repo) {
		this.repo = repo;
	}

	public List<AlbumDTO> getList() {
		return converter.convertToDTO(repo.getList());
	}

	public void save(AlbumDTO dto) throws Exception {
		repo.persist(converter.convertToBO(dto));
	}

	public void delete(AlbumDTO dto) {
		repo.delete(converter.convertToBO(dto));
	}
	
	public void resetRepo() throws Exception {
		repo.init();
	}
}
