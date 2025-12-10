package utez.edu.mx.back.modules;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PlaceService {

    @Autowired
    private PlaceRepository placeRepository;

    public List<Place> getAllPlaces() {
        return placeRepository.findAll();
    }

    public Optional<Place> getPlaceById(Long id) {
        return placeRepository.findById(id);
    }

    public Place createPlace(PlaceDTO placeDTO) {
        Place place = new Place();
        place.setName(placeDTO.getName());
        place.setDescription(placeDTO.getDescription());
        place.setLat(placeDTO.getLat());
        place.setLng(placeDTO.getLng());

        return placeRepository.save(place);
    }

    public void deletePlace(Long id) {
        placeRepository.deleteById(id);
    }
}