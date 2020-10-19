From: Thomas =?ISO-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Date: Mon, 19 Oct 2020 19:59:06 +0200
Message-ID: <5403195.DvuYhMxLoT@...2258...>
In-Reply-To: <20201004160813.GO976@...1296...>
References: <b1352a58-c9a1-ab2d-f85d-c419c8887ef0@...515...>
 <1759346.tdWV9SEqCh@...2258...> <20201004160813.GO976@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.5-rc1 released unable to redirect
 IPv4 default gateway under Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am Sonntag, 4. Oktober 2020, 18:08:13 CEST schrieben Sie:
> Hi Thomas,
>=20
> On Tue, Sep 22, 2020 at 04:21:49PM +0200, Thomas Sch=E4fer wrote:
> > I get
> > Note: unable to redirect IPv4 default gateway -- Cannot read current
> > default gateway from system
> I'm fairly sure I found this, and a fix has been merged today.
>=20
> I expect us to release a RC3 this week, so it can be thoroughly tested.


I went back to the university tonight just in the moment I saw rc3.

No wonder: I can confirm it works now as expected.

Tested with the windows installer package (amd) and with linux source tar=20
ball.

Thank you!

Thomas






