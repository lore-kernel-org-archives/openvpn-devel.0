Message-ID: <005901c42ca7$e7226c90$65ecd3d8@...202...>
From: "Derek Burdick" <derek@...201...>
References: <twig.1083091691.91354@...41...>
Subject: Re: [Openvpn-devel] Windows and Shaper
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0056_01C42C75.3F2E6F20"
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
Date: Tue Apr 27 15:38:02 2004
To: openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

This is a multi-part message in MIME format.

------=_NextPart_000_0056_01C42C75.3F2E6F20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Here is the function.  Don't forget to #DEFINE HAVE_GETTIMEOFDAY in
config-win32.h.  Let me know what you think.

Derek Burdick
----- Original Message ----- 
From: "James Yonan" <jim@...41...>
To: "Derek Burdick" <derek@...201...>;
<openvpn-devel@lists.sourceforge.net>
Sent: Tuesday, April 27, 2004 12:48 PM
Subject: Re: [Openvpn-devel] Windows and Shaper


> Derek Burdick <derek@...201...> said:
>
> >     I was browsing the online CVS repository and noticed the
> > config-win32.h.in says that HAVE_GETTIMEOFDAY is specified in misc.c.
When
> > I look in misc.c, I don't see the file.  Is the latest version just not
> > checked in?  I also implemented a gettimeofday for windows.  It is based
on
> > QueryPerformanceCounter. If you are interested in this version let me
know.
> > If somebody knows the correct status of gettimeofday for the cvs code, I
> > would appreciate an update.
>
> Derek,
>
> Yes, I'd like to see your gettimeofday for Windows that uses
> QueryPerformanceCounter.  OpenVPN 2.0 will have a gettimeofday function
for
> Windows so that --shaper and --mode server can be supported.
>
> James
>
>

------=_NextPart_000_0056_01C42C75.3F2E6F20
Content-Type: application/octet-stream;
	name="windows-gtod.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="windows-gtod.diff"

--- openvpn-1.5.0/misc.c	Thu Nov  6 06:45:12 2003=0A=
+++ openvpn-1.5.0-win/misc.c	Tue Apr 27 16:02:52 2004=0A=
@@ -678,3 +678,56 @@=0A=
       ++cp;=0A=
     }=0A=
 }=0A=
+=0A=
+#ifdef HAVE_GETTIMEOFDAY=0A=
+#ifdef WIN32=0A=
+static double counterPerMicrosecond =3D -1.0;=0A=
+static unsigned __int64 frequency =3D 0;=0A=
+static unsigned __int64 timeSecOffset =3D 0;=0A=
+static unsigned __int64 startPerformanceCounter =3D 0;=0A=
+=0A=
+/*=0A=
+ * gettimeofday for windows=0A=
+ *=0A=
+ * CounterPerMicrosecond is the number of counts per microsecond.=0A=
+ * Double is required if we have less than 1 counter per microsecond.  =
This has not been tested.=0A=
+ * On a PIII 700, I get about 3.579545.  This is guaranteed not to =
change while the processor is running.=0A=
+ * We really don't need to check for loop detection.  On my machine it =
would take about 59645564 days to loop.=0A=
+ * (2^64) / frequency / 60 / 60 / 24.=0A=
+ *=0A=
+ */=0A=
+int gettimeofday(struct timeval *tv, long *ignored)=0A=
+{=0A=
+	unsigned __int64 counter;=0A=
+=0A=
+	QueryPerformanceCounter((LARGE_INTEGER *) &counter);=0A=
+=0A=
+	if (counter < startPerformanceCounter || counterPerMicrosecond =3D=3D =
-1.0)=0A=
+	{=0A=
+		time_t t;=0A=
+		mutex_lock (L_GETTIMEOFDAY);=0A=
+=0A=
+		QueryPerformanceFrequency((LARGE_INTEGER *) &frequency);=0A=
+=0A=
+		counterPerMicrosecond =3D (double)frequency / 1000000.0f;=0A=
+=0A=
+		time(&t);=0A=
+		QueryPerformanceCounter((LARGE_INTEGER *) &counter);=0A=
+		startPerformanceCounter =3D counter;=0A=
+=0A=
+		counter /=3D frequency;=0A=
+=0A=
+		timeSecOffset =3D t - counter;=0A=
+=0A=
+		mutex_unlock (L_GETTIMEOFDAY);=0A=
+		QueryPerformanceCounter((LARGE_INTEGER *) &counter);=0A=
+	}=0A=
+=0A=
+	tv->tv_sec =3D (counter / frequency) + timeSecOffset;=0A=
+	tv->tv_usec =3D ((__int64)(counter / counterPerMicrosecond) % 1000000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+#endif /* WIN32 */=0A=
+#endif /* HAVE_GETTIMEOFDAY */=0A=

------=_NextPart_000_0056_01C42C75.3F2E6F20--


