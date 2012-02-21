MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012934331F4@...1436...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOBzU4M02rr2U0kT6F=5s=NAX58AnbJZ+QfO2fZTPGyNnR1+7Q@...278...>
	<CAOazyz1MKVbzzGPLdVNKzaUKuVUj11awdPVwCejDtf8zKjhW6A@...278...>
	<CAOBzU4PtoHi66QDaKuL6FX55cyccwgfS+0vZ4SOR3dBhNMMXKQ@...278...>
	<CAOazyz2yKB5+SSK1cjWWnVryKxoYvxJjpE39ZTv+6_fBKvFmpQ@...278...>
	<CAOazyz0MzDDGW=A9SnwW2z7HSXW7XMocAvtvr_qKvF65qjbZuA@...278...>
	<1CED409804E2164C8104F9E623B08B90129343318D@...1436...>
	<CAOazyz2CRrbmWMUS9we9v-0m_DYToTD9_6pfw4kK36Rc+5brgA@...278...>
	<1CED409804E2164C8104F9E623B08B9012934331F4@...1436...>
Date: Tue, 21 Feb 2012 13:46:35 +0200
Message-ID: <CAOazyz1yj5=jin2jVbPAsDbybow=1-f=4GKVL-KeXQSz43N6VA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Frank de Brabander <debrabander@...277...>

On Tue, Feb 21, 2012 at 1:39 PM, Adriaan de Jong <dejong@...1435...> wrote:
> Does pkgconfig work/exist across many platforms, or is it a dependency th=
at might hurt us on for example Mac OS, Windows or *BSD? The reason why I a=
sk is that an argument against other systems such as scons and cmake was th=
at they created extra build dependencies. Is it difficult to install, or is=
 it shipped by default on most platforms?

From my experience with a lot of other projects, pkg-config exists in
most of them.
And when it is absent it is not too complex to specify the
*_CFLAGS/*_LIBS for the dependencies.
We have an open issue with OSX, we will see how it goes... but I
almost sure it also has pkg-config...

