MIME-Version: 1.0
In-Reply-To: <4FEC9804.2070805@...1227...>
References: <4FEC9804.2070805@...1227...>
Date: Thu, 28 Jun 2012 20:58:45 +0300
Message-ID: <CAOazyz2XQwSOM5HomPcrv=H0gx_wMCXtqONgz86n=ZKaZ9F0kw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --management-external-key in
	2.3alpha
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hmmm.... I discussed this before in list... the whole external key
should be modified... the management should be able to support
certificate + key, and key should probably not be limited to RSA only.
I had plans to clean this one as well.

On Thu, Jun 28, 2012 at 8:44 PM, Arne Schwabe <arne@...1227...> wrote:
>
>
> Just a quick patch which fixes =C2=A0--management-external-key, which I n=
eed
> for a cleaner way to access Android key store.
>
> Arne
>
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

