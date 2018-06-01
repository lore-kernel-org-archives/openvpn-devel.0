MIME-Version: 1.0
In-Reply-To: <1527828655.645316.1392609712.3E887A89@...2307...>
References: <1527819161.492538.1392521184.3CB7A30B@...2307...>
 <CAKuzo_iGmzY-D1Bn07fD89uWVuVDq-s622vtd21Tnn3oyuHF8A@...278...>
 <1527828655.645316.1392609712.3E887A89@...2307...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 1 Jun 2018 01:33:30 -0400
Message-ID: <CAKuzo_ifdaAb-nGgc2Z51-505j+J+kb_FbkQoVNodjVQD-qJjQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5_git fails to build linked to
 OpenSSL v1.1.0 Works great linked to OpenSSL v1.0.2 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: aclion@...2404...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

>
> No, OpenSSL 1.1.0 is configured with
>
>     --api=1.1.0 \
>
> as it should be to NOT have/use deprecated compat interfaces,

I think that is identical to setting -DOPENSSL_API_COMPAT to 1.1 and
will not work.

OpenVPN still supports openssl 1.0 and you can't build with api
restricted to 1.1. At least not yet. So it will build only if you use
the "default build" of OpenSSL 1.1. And should build with 1.1
lib/headers in major distributions -- if not, there is a problem.

Selva

