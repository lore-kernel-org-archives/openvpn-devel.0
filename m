MIME-Version: 1.0
In-Reply-To: <CAKuzo_it8Y25Z0Bw4i-X+FiY80K2cT9X5Q7oQ4wxN-Ds_SPAOA@...278...>
References: <CAEsd45Q9S_V137M5Db5jNT2ZFGju8XKMAUYqBeDYifjC5y=-MQ@...278...>
	<CAKuzo_it8Y25Z0Bw4i-X+FiY80K2cT9X5Q7oQ4wxN-Ds_SPAOA@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 12 Dec 2015 21:31:41 -0500
Message-ID: <CAEsd45R3t63kG=x8o9rxUB98sDqKtGK9kw424BaPag43X55O=w@...278...>
Subject: Re: [Openvpn-devel] Options that are "safe" for users to modify?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Thanks, Selva.

On Sat, Dec 12, 2015 at 5:43 PM, Selva Nair <selva.nair@...277...> wrote:
> I suppose, not just adding but also removing options will be allowed. There
> could be more options that are ok (i.e not unsafe) to remove but not change.

What I'm proposing isn't to allow "add/remove/modify" options in the
OpenVPN configuration file, but to allow the replacement of the
contents of files that are referred to in options in it. I admit that
is a much less general approach.


>> --pkcs1

Sorry, should have been --pkcs12


>> --static

Sorry, should have been --secret


>> --ta
>
> --ta ?

Oops. No, sorry, that was just plain wrong.

The corrected list is:

--askpass
--auth-user-pass
--ca
--cert
--dh
--extra-certs
--key
--pkcs12
--secret
--tls-auth

I'm not clear at all about --crl-verify. Would it ever be used in a
client? Would there be a security risk if a client erased the contents
of the file? (Would that allow a client to connect to a server that
has a revoked certificate which would otherwise not be allowed?
**That** would be a security problem.)


> As remote cant change, several more options may be safe, though note
> necessarily very useful. Here are a couple of options that could help when
> the server is updated, for example
>
> --topology  t  (mainly to remove from client so that a new setting at the
> server can take effect through push -- say moving from net30 to subnet)
> --comp-lzo
> --secret  (for non-tls)
> --auth
> --cipher

I'm not (at this point, anyway) talking about changing options in the
configuration file, I'm talking about changing the contents of files
**referred to** in the configuration file. (So yes to --secret, which
I mistyped as --static, but no to the others. I think they are
configuration changes that warrant an admin doing them.)

