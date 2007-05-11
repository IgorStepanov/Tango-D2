/*******************************************************************************

        copyright:      Copyright (c) 2007 Kris Bell. All rights reserved

        license:        BSD style: $(LICENSE)

        version:        Jan 2007 : initial release
        
        author:         Kris 

*******************************************************************************/

module tango.io.protocol.PickleProtocol;

private import  tango.io.protocol.EndianProtocol,
                tango.io.protocol.NativeProtocol;

/*******************************************************************************

*******************************************************************************/

version (BigEndian)
         public alias NativeProtocol PickleProtocol;
      else
         public alias EndianProtocol PickleProtocol;

/*******************************************************************************

*******************************************************************************/

debug (UnitTest)
{
        import tango.io.Buffer;

        void main() {}

        unittest
        {
                int test = 0xcc55ff00;
                
                auto protocol = new PickleProtocol (new Buffer(32));
                protocol.write (&test, test.sizeof, protocol.Type.Int);

                auto ptr = protocol.buffer.slice (test.sizeof, false).ptr;
                protocol.read  (&test, test.sizeof, protocol.Type.Int);
                
                assert (test == 0xcc55ff00);
                
                version (LittleEndian)
                         assert (*cast(int*) ptr == 0x00ff55cc);
        }
}





