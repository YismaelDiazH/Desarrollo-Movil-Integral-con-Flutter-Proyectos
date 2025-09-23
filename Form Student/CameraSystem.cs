using UnityEngine;

public class CameraSystem :MonoBehaviour
{


    public Transform spaceship;
    public Vector3 offset;
    public transform cameraObject;


    void Update()
    {

        Vector3 direction = (spaceship.position - transform.position).normalized;

        cameraObject.rotation = Quaternion.LookRotation(direction);

        transform.Rotate(Vector3.up, Input.mousePositionDelta.x * 0.5f);



        trasnsform.position = spaceship.position;
        cameraObject.localPosition =  offset;
        
        

}

}
