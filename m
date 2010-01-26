Date: Tue, 26 Jan 2010 10:35:45 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B5E2895.4030906@...1299...>
In-Reply-To: <4B5E2895.4030906@...1299...> (from Jason.Haar@...1299...
	on Mon Jan 25 17:26:13 2010)
Message-Id: <1264523745.26411.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] win32 openvpn-2.1.1 has bug with "nobind"?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Jason Haar <Jason.Haar@...1299...>
Cc: openvpn-devel@lists.sourceforge.net

On 01/25/2010 05:26:13 PM, Jason Haar wrote:

> In general it works well, but once in a while, restarting openvpn
> doesn't work - you get some vague "cannot access" error. Waiting some
> minutes or rebooting will always fix the problem. Ends up that=20
> running
> "netstat -an" in this situation shows that something is associated
> with
> udp port 1194 - svchosts.exe. When this happens, waiting until 1194
> disappears from netstat means I'm able to start openvpn successfully.


Sounds like the 2MSL problem described in this thread:
http://sourceforge.net/mailarchive/forum.php?thread_name=3D1263527105.29484=
.1%40mofo&forum_name=3Dopenvpn-devel


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


