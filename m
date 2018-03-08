From: Arne Schwabe <arne@...1227...>
References: <1520262951-1807-1-git-send-email-arne@...1227...>
Message-ID: <4c8dbc1b-71c9-6187-5ecf-f1dbfb957561@...1227...>
Date: Thu, 8 Mar 2018 16:02:22 +0100
MIME-Version: 1.0
In-Reply-To: <1520262951-1807-1-git-send-email-arne@...1227...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Rework OpenVPN auth-token support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

The discussion has gone on a bit about this patch. I would like to step
back and give an overview to make this mess better understandable as we
have multiple problem mixed together.

Current client behaviour:

- (a) OpenVPN 3. Forgets auth-token on reconnect, can be told to forget
auth-token during a session with AUTH_FAILED,SESSION

- (b) OpenVPN 2.x Once it gets an auth-token, the auth-token replace the
password and the client will never anything else from that point on

Proposed new behaviour:

- (c) OpenVPN 2.x should behave exactly like OpenVPN 3

- (d) OpenVPN 2.x if not intrustucted otherwise will keep auth-token on
reconnect but will forget it as soon as it gets an AUTH-FAILED (what my
patch proposed)


Current OpenVPN server behaviour:

- (i) Custom client-connect script with auth-token can send an
auth-token and can also check the same token on reconnect

- (ii) auth-gen-token sends an auth-token but the auth-token is only
valid for the session. The token can also set to expiry earlier in which
case the server fails to notify the client about th failed auth-token.


Currently working combinations are (i)+(a) and ii+b. OpenVpn 3 with
custom script (i+b) will also work but will query for password/OTP
password on every reconnect/network change.

Current problems:

- (1) OpenVPN 2.x server does only signal AUTH-FAILED on the initial tls
session but not on later ones (I am ingoring the management special case
here)

- (2) OpenVPN 2.x client does not understand AUTH_FAILED,SESSION


- (3) OpenVPN 2.x client (b) against an auth-gen-token server (ii):
Client will use the auth-token buth the server does not know anything
anymore about the token and the authentication fails


Problem (1) and (2) are unproblematic as far as the discussion goes as
there is no doubt that we should "just" implement them in 2.x.


Fixes for (3), client side:

- Using new behaviour (c), like OpenVPN 3. This will work but will make
the custom script solution (i) worse and also has more real
authentication on network changes. At least I see no reason why a token
after an OTP password should be invalidated after a network change.


- Using new behaviour (d): Will continue to work with custom script as
before. Will also be able to recover when connecting to to an
*unpatched* auth-gen-token server but will need two attempts on a
reconnect since the first fails with an AUTH_FAILED.


- In either (c) and (d) as new client behaviour, there should be a
pushable option that allows the server to select the auth-token
behaviour on reconnect (forget or keep)


Fixes for the server side for (3):

- implement persistent auth-tokens: Will allow old clients (b) to
reconnect. Maybe change expire time to be "after not being used for x
hours". Old clients will still fail to reconnect if the server is
restarted unless tokens survive server restart.

- do not send auth-token to client that have behaviour (b). For this to
happen the server needs to know if a client has behaviour (b) or not.

My suggestion here was to increase IV_PROTO to 3. The 3 here should only
signal that the client has some way of dealng with an expiring token on
reconnect and that the current behaviour of auth-gen-token is safe to
use. It does not matter if the client recovers from AUTH-FAILED when a
token is in use or if the client forgets the token. (minimal common
behsaviour).  IV_PROTO should also include "understand AUTH_FAILED,SESSION"

This has been a long mail but I hope it clear ups some of the confusion.

Arne

