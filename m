References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
	<a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
	<2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
	<CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
	<17692092-d40d-72cb-381e-98177668250d@...2181...>
	<50bec2e7-9f29-d36f-72fe-3b1d45fb0150@...2181...>
	<CAFHpkQEQYw7MVasWjr24xn83MWuoiSL9=TOm-d7-9FGANq6s1Q@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <2188fbcb-0cfd-ee4f-11db-37145ea5fff2@...1435...>
Date: Thu, 13 Jul 2017 11:53:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEQYw7MVasWjr24xn83MWuoiSL9=TOm-d7-9FGANq6s1Q@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 13-07-17 08:49, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> 2017-07-13 11:46 GMT+05:00 Antonio Quartulli <a@...2181...
> <mailto:a@...2181...>>:
>     On 13/07/17 14:45, Antonio Quartulli wrote:
>     > $ git tag --contains eed9b8eec911a26a952f07ad18d4397c334ac089
>     > v2.3.10
>     > v2.3.11
>     > v2.3.12
>     > v2.3.13
>     > v2.3.14
>     > v2.3.15
>     > v2.3.16
>     > v2.3.17
>     > v2.3.2
>     > v2.3.3
>     > v2.3.4
>     > v2.3.5
>     > v2.3.6
>     > v2.3.7
>     > v2.3.8
>     > v2.3.9
>     >
>     >
>     > Hence, 2.3 is broken starting at v2.3.9. This is confirmed by the f=
act
>     > that release/2.3 does not compile with --disable-multi.
>     >
>=20
>     typ0: I meant starting at 2.3.2.
>=20
> so, if nobody care about something broken since 2.3.2, lets drop it

Yes, this.  Let's drop the configure flag and unnecessary ifdefs.

-Steffan

