MIME-Version: 1.0
In-Reply-To: <4F9A9B06.8080105@...515...>
References: <4F9A9B06.8080105@...515...>
Date: Fri, 27 Apr 2012 16:20:22 +0300
Message-ID: <CAOazyz12EN3XN0Yq_F4x6yAtOexuZ559R38ZPYwg3VenPowghw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Passing custom configure flags to "generic"
	buildsystem?
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/4/27 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi,
>
> What is the recommended way of passing configure flags to the "generic"
> buildsystem? I'd like to cross-compile for win64 on Linux and have some
> features turned on.
>
> Samuli

Hello,

Just define the EXTRA_OPENVPN_CONFIG environment variable.
Or I don't understand your question....

Alon.

