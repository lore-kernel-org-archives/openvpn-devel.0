Message-Id: <ICS8JH$B6304D7AF00C681F7D7572A8E13B88A9@...354...>
MIME-Version: 1.0
From: "andi\.c\@libero\.it" <andi.c@...354...>
Subject: [Openvpn-devel] Problem with TAP under Win32: how read correcty
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Mar  3 07:34:38 2005
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi guy,
i ve am writing a Win32 app that makes use of TAP
drivers bundled with OpenVPN.
I ve looked at tun.c to understand how control and mange
the virtual interface, but i ve a big problem:
i can open the device, read driver verion, mtu etcc...
but when i try to read the data submitted by the os
with a ReadFile call, i obtain corrupted packets.
Now, my tap interface has to receive ipv6 traffic, but
when i call ping6 on it, the buffer i read with ReadFile
is smaller (86 bytes vs 216) and differend from
a correct buffer i read under linux (where all works).

I post the code i use to open the device and read it,
can someone take a look and tell me if i ve missing
something ? thanks!!!

--------------------------------------------
int device_number =3D 0;
while (true)
{=0D
	device_guid =3D get_unspecified_device_guid (device_number,
		guid_buffer,
		sizeof (guid_buffer),
		tap_reg,
		panel_reg,
		&gc);

	if (!device_guid)
		printf("All TAP-Win32 adapters on this system are currently in
                 use.");

	/* Open Windows TAP-Win32 adapter */
	sprintf(device_path,
               "%s%s%s",USERMODEDEVICEDIR,device_guid,TAPSUFFIX);

	user_data.tunFile =3D CreateFile (
		 	device_path,
			GENERIC_READ | GENERIC_WRITE,
			0, /* was: FILE_SHARE_READ */=0D
			0,
			OPEN_EXISTING,
			FILE_ATTRIBUTE_SYSTEM,
			0
			);

	if (user_data.tunFile =3D=3D INVALID_HANDLE_VALUE)
		printf("CreateFile failed on TAP device: %s\n", device_path);
         else
	{
		printf("CreateFile succeedeed on TAP device: %s\n",
                           device_path);
		break;
	}

		device_number++;
}

actual_name =3D string_alloc (guid_buffer, NULL);
printf("TAP-WIN32 device [%s] opened\n\tpath: %s\n", actual_name, device_pa=
th);


/* Get drivers version */
ULONG info[3];
CLEAR (info);
if (DeviceIoControl (user_data.tunFile, TAP_IOCTL_GET_VERSION,&info,
            sizeof (info),&info, sizeof (info), &len, NULL))
{
	printf("TAP-Win32 Driver Version %d.%d %s\n",(int) info[0],(int)
           info[1],(info[2] ? "(DEBUG)" : ""));
}
=20=20=20
if ( !(info[0] > TAP_WIN32_MIN_MAJOR || (info[0] =3D=3D TAP_WIN32_MIN_MAJOR=
 &&
info[1] >=3D TAP_WIN32_MIN_MINOR)) )
      printf("ERROR:  This version of the program requires a TAP-Win32
       driver");

/* get driver MTU */
ULONG mtu;
if (DeviceIoControl (user_data.tunFile, TAP_IOCTL_GET_MTU,&mtu, s izeof
(mtu),&mtu, sizeof (mtu), &len, NULL))
     printf("TAP-Win32 MTU=3D%d\n", (int) mtu);


/* set driver media status to 'connected' */
ULONG status =3D TRUE;
if (!DeviceIoControl(user_data.tunFile,TAP_IOCTL_SET_MEDIA_STATUS,
        &status, sizeof (status),&status, sizeof (status), &len, NULL))
	      printf("WARNING: The TAP-Win32 driver rejected th call");
else
	printf("The TAP-Win32 driver accepted the
          TAP_IOCTL_SET_MEDIA_STATUS DeviceIoControl call.\n");


/* READ ON DEVICE TAP 1 */
status =3D ReadFile(
		user_data.tunFile,
		buffer,   // <-- here is the error
		2000,
		&dwBytesRead,

	NULL
		);=20



____________________________________________________________
6X velocizzare la tua navigazione a 56k? 6X Web Accelerator di Libero!
Scaricalo su INTERNET GRATIS 6X http://www.libero.it



