Date: Wed, 03 Mar 2010 09:31:35 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <1267588345473303500@...1315...> <4B8E2070.6050208@...1299...>
In-Reply-To: <4B8E2070.6050208@...1299...> (from Jason.Haar@...1299...
	on Wed Mar  3 02:40:16 2010)
Message-Id: <1267630295.5048.3@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Erratic TCP Throughput
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
To: openvpn-devel@lists.sourceforge.net

On 03/03/2010 02:40:16 AM, Jason Haar wrote:
> On 03/03/2010 04:52 PM, openvpn@...1315... wrote:
> >
> > 1) Without OpenVPN - consistent performance, ~ 70 Mbps total
> > throughput (on a 100 Mb LAN).

> > 2) With OpenVPN - very consistent performance, sometimes fine,=20
> other
> > times very poor. ~ 70 Mbps total throughput (on a 100 Mb LAN), but
> > bounces around a lot.

> So what you're saying is that on a ~70Mbs network you sometimes see
> ~70Mbs via "openvpn-via-proxy-server" and sometimes you don't? As the
> performance of openvpn varies - and I assume you know the client and
> server aren't the bottleneck - then that leaves....?
>=20
> The proxy! :-)=20

Or problems with tunneling tcp inside tcp which you can trace
back via this thread:

http://article.gmane.org/gmane.network.openvpn.user/29183



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


