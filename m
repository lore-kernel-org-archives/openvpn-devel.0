From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 7 Feb 2012 08:29:33 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90129328A993@...1436...>
References: <4F307A83.8020606@...1388...>
In-Reply-To: <4F307A83.8020606@...1388...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Assertion failed at buffer.c:313
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
To: Michal Ludvig <mludvig@...1388...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thank you, that patch had more impact than I thought it would. I'm sorry ab=
out the inconvenience, it's a bug I'm looking into at the moment.=20

David, could you revert the patch please, so I have a little more time to r=
efactor there? I'm looking into the best way to refactor that function with=
 a minimal risk of causing new memory leaks.

Adriaan

> -----Original Message-----
> From: Michal Ludvig [mailto:mludvig@...1388...]
> Sent: dinsdag 7 februari 2012 2:13
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] Assertion failed at buffer.c:313
>=20
> Hi guys
>=20
> I experience "Assertion failed at buffer.c:313" on my RHEL5/x64 caused
> by:
>=20
> commit bee92b479414d12035b0422f81ac5fcfe14fa645
> Author: Adriaan de Jong <dejong@...1435...>
> Date:   Sun Feb 5 12:51:25 2012 +0100
>=20
>      Removed support for calling gc_malloc with a NULL gc_arena struct
>=20
> Once this patch is reverted OpenVPN compiles and runs smoothly.
>=20
> Michal
>=20
> -----------------------------------------------------------------------
> -------
> Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3,
> MVC3, Metro Style Apps, more. Free future releases when you subscribe
> now!
> http://p.sf.net/sfu/learndevnow-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

