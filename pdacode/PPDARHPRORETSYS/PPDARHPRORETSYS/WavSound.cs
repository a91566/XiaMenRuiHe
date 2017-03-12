using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;//dll
using System.IO;

namespace PPDARHPRORETSYS
{
    class WavSound
    {
        private static byte[] m_soundBytes;
        

        private enum Flags
        {
            SND_SYNC = 0x0000,  /* play synchronously (default) */
            SND_ASYNC = 0x0001,  /* play asynchronously */
            SND_NODEFAULT = 0x0002,  /* silence (!default) if sound not found */
            SND_MEMORY = 0x0004,  /* pszSound points to a memory file */
            SND_LOOP = 0x0008,  /* loop the sound until next sndPlaySound */
            SND_NOSTOP = 0x0010,  /* don't stop any currently playing sound */
            SND_NOWAIT = 0x00002000, /* don't wait if the driver is busy */
            SND_ALIAS = 0x00010000, /* name is a registry alias */
            SND_ALIAS_ID = 0x00110000, /* alias is a predefined ID */
            SND_FILENAME = 0x00020000, /* name is file name */
            SND_RESOURCE = 0x00040004  /* name is resource name or atom */
        }

        [DllImport("CoreDll.DLL", EntryPoint = "PlaySound", SetLastError = true)]
        private extern static int WCE_PlaySound(string szSound, IntPtr hMod, int flags);

        [DllImport("CoreDll.DLL", EntryPoint = "PlaySound", SetLastError = true)]
        private extern static int WCE_PlaySoundBytes(byte[] szSound, IntPtr hMod, int flags);


        /// <summary>
        /// Construct the Sound object to play sound data from the specified stream.
        /// </summary>
        public WavSound(Stream stream)
        {
            // read the data from the stream
            m_soundBytes = new byte[stream.Length];
            stream.Read(m_soundBytes, 0, (int)stream.Length);
        }

        /// <summary>
        /// Play the sound
        /// </summary>
        public static void Play()
        {            
            string m_fileName = @"\Application\Startup\decode.wav";

            if (m_fileName != null)
                WCE_PlaySound(m_fileName, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_FILENAME));
            else
                WCE_PlaySoundBytes(m_soundBytes, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_MEMORY));
        }



        public void Stop()
        {
            string m_fileName = @"\Application\Startup\decode.wav";

            if (m_fileName != null)
                WCE_PlaySound(null, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_FILENAME));
            else
                WCE_PlaySoundBytes(null, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_MEMORY));
        }


        public static void PlayError()
        {
            string m_fileName = @"\Application\Startup\error.wav";

            if (m_fileName != null)
                WCE_PlaySound(m_fileName, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_FILENAME));
            else
                WCE_PlaySoundBytes(m_soundBytes, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_MEMORY));
        }

        public static void PlayPause()
        {
            string m_fileName = @"\Application\Startup\pause.wav";

            if (m_fileName != null)
                WCE_PlaySound(m_fileName, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_FILENAME));
            else
                WCE_PlaySoundBytes(m_soundBytes, IntPtr.Zero, (int)(Flags.SND_ASYNC | Flags.SND_MEMORY));
        }

    }
}
