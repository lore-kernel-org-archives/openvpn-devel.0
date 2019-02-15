References: <20190122150333.1061-1-arne@...1227...>
 <20190122150333.1061-4-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d1900648-2ba5-0e0b-8402-d1fa672fa741@...2080...>
Date: Fri, 15 Feb 2019 22:56:28 +0100
MIME-Version: 1.0
In-Reply-To: <20190122150333.1061-4-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 4/6] Implement a permanent session id
 in auth-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>

On 22/01/2019 16:03, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> This allows an external authentication method
> (e.g. management interface) to track the connection and distinguish a
> reconnection from multiple connections.
> 
> Addtionally this now also checks to workaround a problem with
> OpenVPN 3 core that sometimes uses a username hint from the config
> instead of using an empty username if the token would be valid
> with an empty username. Accepting such token can only be explicitly
> done if the auth keyword to auth-gen-token is present.
Meh .... I'm not sure about this feature at all.  I understand the use case
for it, but I don't see the full benefit of it.  Why?  Because if you still
want to do partially authentication based on and existing auth-token, why
can't you implement the full auth-token pushing in the auth-backend?

And with the trap that incorrectly implementing the "auth" mode, where it
would actually by default accept invalid tokens is a no-go from a security
perspective.

The background for --auth-gen-token was primarily to make life easier for
users using auth-backends NOT supporting auth-tokens and who had issues with
tunnel renegotiations.

Extending --auth-gen-token with a secret so it can handle server-side restarts
without breaking already authenticated clients is a nice feature.  Even the
possibility to share this secret among multiple servers providing connection
migrations without authentication breakage are all good features.

But pushing this towards a new level where token expiry/validity checks is
still pushed towards an external authentication module I find stretching this
feature a bit too much.  And in particular if the auth backend is not tackling
invalidated tokens correctly results in authentication success.

In this case, why can't the auth backend do everything?


-- 
kind regards,

David Sommerseth
OpenVPN Inc


