package com.tatoado.ramabluewingood;

import com.google.zxing.integration.IntentIntegrator;
import com.google.zxing.integration.IntentResult;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {

    Button btn1, btn2,btn3,btn4,btn5,btn6,btna,btnb,btnc, btnLeche, btnScan;

    private BluetoothAdapter btAdapter = null;
    private BluetoothSocket btSocket = null;
    private StringBuilder recDataString = new StringBuilder();

    private ConnectedThread mConnectedThread;

    // SPP UUID service - this should work for most devices
    private static final UUID BTMODULEUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    // String for MAC address
    private static String address = null;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);

        //Link the buttons and textViews to respective views
        btn1 = (Button) findViewById(R.id.button1);
        btn2 = (Button) findViewById(R.id.button2);
        btn2 = (Button) findViewById(R.id.button2);
        btn3 = (Button) findViewById(R.id.button3);
        btn4 = (Button) findViewById(R.id.button4);
        btn5 = (Button) findViewById(R.id.button5);
        btn6 = (Button) findViewById(R.id.button6);
        btna = (Button) findViewById(R.id.buttona);
        btnb = (Button) findViewById(R.id.buttonb);
        btnc = (Button) findViewById(R.id.buttonc);
        btnLeche = (Button)findViewById(R.id.btnLeche);
        btnScan = (Button)findViewById(R.id.btnScan);


        btAdapter = BluetoothAdapter.getDefaultAdapter();       // get Bluetooth adapter
        checkBTState();


        // Set up onClick listeners for buttons to send 1 or 0 to turn on/off LED
        btn1.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("1");    // Send "0" via Bluetooth
                Toast.makeText(getBaseContext(), "1", Toast.LENGTH_SHORT).show();
            }
        });

        btn2.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("2");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "2", Toast.LENGTH_SHORT).show();
            }
        });
        btn3.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("3");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "3", Toast.LENGTH_SHORT).show();
            }
        });
        btn4.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("4");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "4", Toast.LENGTH_SHORT).show();
            }
        });
        btn5.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("5");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "5", Toast.LENGTH_SHORT).show();
            }
        });
        btn6.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("6");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "6", Toast.LENGTH_SHORT).show();
            }
        });
        btna.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("a");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "a", Toast.LENGTH_SHORT).show();
            }
        });
        btnb.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("b");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "b", Toast.LENGTH_SHORT).show();
            }
        });
        btnc.setOnClickListener(new OnClickListener() {
            public void onClick(View v) {
                mConnectedThread.write("c");    // Send "1" via Bluetooth
                Toast.makeText(getBaseContext(), "c", Toast.LENGTH_SHORT).show();
            }
        });

        btnLeche.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                mConnectedThread.write("000150lecheleche");
                Toast.makeText(getBaseContext(),"000150lecheleche", Toast.LENGTH_SHORT).show();
            }
        });

        btnScan.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                //Se instancia un objeto de la clase IntentIntegrator
                IntentIntegrator scanIntegrator = new IntentIntegrator(MainActivity.this);
                //Se procede con el proceso de scaneo
                scanIntegrator.initiateScan();
            }
        });

    }


    private BluetoothSocket createBluetoothSocket(BluetoothDevice device) throws IOException {

        return  device.createRfcommSocketToServiceRecord(BTMODULEUUID);
        //creates secure outgoing connecetion with BT device using UUID
    }

    @Override
    public void onResume() {
        super.onResume();

        //Get MAC address from DeviceListActivity via intent
        Intent intent = getIntent();

        //Get the MAC address from the DeviceListActivty via EXTRA
        address = intent.getStringExtra(DeviceListActivity.EXTRA_DEVICE_ADDRESS);

        //create device and set the MAC address
        //Log.i("ramiro", "adress : " + address);
        BluetoothDevice device = btAdapter.getRemoteDevice(address);

        try {
            btSocket = createBluetoothSocket(device);
        } catch (IOException e) {
            Toast.makeText(getBaseContext(), "La creacción del Socket fallo", Toast.LENGTH_LONG).show();
        }
        // Establish the Bluetooth socket connection.
        try
        {
            btSocket.connect();
        } catch (IOException e) {
            try
            {
                btSocket.close();
            } catch (IOException e2)
            {
                //insert code to deal with this
            }
        }
        mConnectedThread = new ConnectedThread(btSocket);
        mConnectedThread.start();

        //I send a character when resuming.beginning transmission to check device is connected
        //If it is not an exception will be thrown in the write method and finish() will be called
        //mConnectedThread.write("x");
    }

    @Override
    public void onPause()
    {
        super.onPause();
        try
        {
            //Don't leave Bluetooth sockets open when leaving activity
            btSocket.close();
        } catch (IOException e2) {
            //insert code to deal with this
        }
    }

    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        //Se obtiene el resultado del proceso de scaneo y se parsea
        IntentResult scanningResult = IntentIntegrator.parseActivityResult(requestCode, resultCode, intent);
        if (scanningResult != null) {
            //Quiere decir que se obtuvo resultado pro lo tanto:
            //Desplegamos en pantalla el contenido del código de barra scaneado
            String scanContent = scanningResult.getContents();
            mConnectedThread.interrupt();
            onPause();
            onResume();
            mConnectedThread.write(scanContent);
            Toast.makeText(getBaseContext(),scanContent, Toast.LENGTH_SHORT).show();

        }else{
            //Quiere decir que NO se obtuvo resultado
            Toast toast = Toast.makeText(getApplicationContext(),
                    "No se ha recibido datos del scaneo!", Toast.LENGTH_SHORT);
            toast.show();
        }
    }


    //Checks that the Android device Bluetooth is available and prompts to be turned on if off
    private void checkBTState() {

        if(btAdapter==null) {
            Toast.makeText(getBaseContext(), "El dispositivo no soporta bluetooth", Toast.LENGTH_LONG).show();
        } else {
            if (btAdapter.isEnabled()) {
            } else {
                Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(enableBtIntent, 1);
            }
        }
    }

    //create new class for connect thread
    private class ConnectedThread extends Thread {
        private final InputStream mmInStream;
        private final OutputStream mmOutStream;

        //creation of the connect thread
        public ConnectedThread(BluetoothSocket socket) {
            InputStream tmpIn = null;
            OutputStream tmpOut = null;

            try {
                //Create I/O streams for connection
                tmpIn = socket.getInputStream();
                tmpOut = socket.getOutputStream();
            } catch (IOException e) { }

            mmInStream = tmpIn;
            mmOutStream = tmpOut;
        }


        public void run() {
            byte[] buffer = new byte[256];
            int bytes;

            // Keep looping to listen for received messages
            while (true) {

            }
        }
        //write method
        public void write(String input) {
            byte[] msgBuffer = input.getBytes();           //converts entered String into bytes
            try {
                for(int i=0;i<msgBuffer.length;i++) {
                    mmOutStream.write(msgBuffer[i]);
                    Handler handler = new Handler();
                    handler.postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            // change image
                        }
                    }, 200); // 100ms delay

                }
            } catch (IOException e) {
                //if you cannot write, close the application
                Toast.makeText(getBaseContext(), e.toString(), Toast.LENGTH_LONG).show();
                finish();

            }
        }
    }
}

