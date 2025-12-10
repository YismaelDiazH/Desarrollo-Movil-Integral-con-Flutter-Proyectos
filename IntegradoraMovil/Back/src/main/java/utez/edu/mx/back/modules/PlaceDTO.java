package utez.edu.mx.back.modules;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlaceDTO {
    private String name;
    private String description;
    private Double lat;
    private Double lng;
}