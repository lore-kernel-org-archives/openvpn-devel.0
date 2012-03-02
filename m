MIME-Version: 1.0
In-Reply-To: <2587657.DLePWL2mdU@...1526...>
References: <2587657.DLePWL2mdU@...1526...>
Date: Fri, 2 Mar 2012 13:23:32 +0200
Message-ID: <CAOazyz0ETRaXkBdAuUF11GpVoKu4X4pV8wfvWa4tWw-Q+1NB6Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] GUI size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

This is already been done in the new build system.

On Fri, Mar 2, 2012 at 10:56 AM, Heiko Hund <heiko.hund@...1489...> wrote:
> Samuli,
>
> I've received a question about the size of the snapshot binaries in the i=
ssue
> tracker yesterday.
>
> https://sourceforge.net/tracker/?func=3Ddetail&atid=3D1327094&aid=3D34961=
02&group_id=3D248281
>
> Could you compile the GUI yourself and link against the openssl crypto DL=
L for
> the next release? The GUI shouldn't be linked statically if there a
> libeay32.dll lying next to it, really.
>
> Thanks
> Heiko
> --
> Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
> Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Ge=
rmany
> Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
>
> Represented by the General Partner Astaro Verwaltungs GmbH
> Amalienbadstra=C3=9Fe 41 Bau 52 | 76227 Karlsruhe | Germany
> Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
> Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Frank Nellissen
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

