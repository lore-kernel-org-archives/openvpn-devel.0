MIME-Version: 1.0
Date: Wed, 4 Mar 2015 18:40:35 -0700
Message-ID: <CAAA5faFSG-SteiMDoLEVEb-RiC0jdFVSrP0X3md38EWybAfETQ@...278...>
From: Reinoud Koornstra <reinoudkoornstra@...277...>
Content-Type: multipart/alternative; boundary=001a1134bd8083306b051080a75c
Subject: [Openvpn-devel] reading from the status file from another pid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a1134bd8083306b051080a75c
Content-Type: text/plain; charset=UTF-8

Hi Everyone,

I've configured openvpn to write the status every 5 seconds to a status
file.
Looking at the code that when openvpn starts you call open()

Then every 5 seconds, the status file is truncated in status_flush.

Only when you close openvpn, the file descriptor will be closed again.
Hence, the file remains open all the time, but is truncated every 5 seconds.

Now I would the read from the status file periodically as well in another
process that is running.
I can open the file just fine, the only issue that makes me incertain is
the truncating of the file every 5 seconds. Currently I am looking for a
safe way to read from the status file, while it is opened and truncated
every 5 seconds.
Any suggestions?
Thanks,

Reinoud.

--001a1134bd8083306b051080a75c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Everyone,<div><br></div><div>I&#39;ve configured openvp=
n to write the status every 5 seconds to a status file.</div><div>Looking a=
t the code that when openvpn starts you call open()</div><div><br></div><di=
v>Then every 5 seconds, the status file is truncated in status_flush.</div>=
<div><br></div><div>Only when you close openvpn, the file descriptor will b=
e closed again.</div><div>Hence, the file remains open all the time, but is=
 truncated every 5 seconds.</div><div><br></div><div>Now I would the read f=
rom the status file periodically as well in another process that is running=
.</div><div>I can open the file just fine, the only issue that makes me inc=
ertain is the truncating of the file every 5 seconds. Currently I am lookin=
g for a safe way to read from the status file, while it is opened and trunc=
ated every 5 seconds.</div><div>Any suggestions?</div><div>Thanks,</div><di=
v><br></div><div>Reinoud.</div></div>

--001a1134bd8083306b051080a75c--

