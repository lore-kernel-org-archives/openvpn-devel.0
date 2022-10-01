Message-ID: <45e3f105-cf84-039e-8719-8facba154389@...1227...>
Date: Sat, 1 Oct 2022 13:44:37 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <CAEBHyEV1TvxTF5rPg8NaUkd8D80er-K50TYf_f42smwCgW8-Wg@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAEBHyEV1TvxTF5rPg8NaUkd8D80er-K50TYf_f42smwCgW8-Wg@...278...>
Subject: Re: [Openvpn-devel] Multiple Openvpn servers using same port + Nginx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Daniel Lando <daniel.sorridi@...277...>, openvpn-devel@lists.sourceforge.net

Am 30.09.22 um 17:20 schrieb Daniel Lando:
> Hi everyone,
> 
> As described in this 
> <https://github.com/OpenVPN/openvpn/pull/166#issuecomment-1263600751> 
> comment, what I would like to know is if it's possible (and how) I could 
> proxy requests using nginx to multiple openvpn servers. I'm actually 
> using docker-compose to start the openvpn servers and also nginx is 
> running in a docker container.

OpenVPN does not use plain TLS over TCP like HTTPS does. Instead it uses 
its own framing that ngix will not understand. So you would need first 
of all a module for nginx that understand openvpn protocol framing.

While a custom proxy could work for that if you had SNI, that is 
something that would first need to be developed and also you would need 
client support for SNI. So far that has been little interest in that, so 
nobody made any advances in that area.

Also in OpenVPN we normally do not implement a feature that cannot be 
used. E.g. just implementing SNI client support without any available 
server implementation, is something that will get rejected.

> 
> The possible solutions I have in mind could be by using subdomains or 
> sni but cannot find a way to make them working as sni support is only 
> available on openvpn 3.

Even in OpenVPN 3 that feature is not used to my knowledge as there is 
no server support implemented anywhere as far as I can tell.

> 
> There is also a webserver that should share the same port

We already have port-share.

Arne

