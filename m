Message-ID: <2e08ab000803170102k5b4070baw43fb555e75e79bff@...278...>
Date: Mon, 17 Mar 2008 09:02:34 +0100
From: "Christophe Vandeplas" <christophe@...1081...>
In-Reply-To: <9e0cf0bf0803161105u71b7afc0tc90fed05da57f0dc@...278...>
MIME-Version: 1.0
References: <47DD4B14.5060009@...1081...>
	<9e0cf0bf0803161105u71b7afc0tc90fed05da57f0dc@...278...>
Subject: Re: [Openvpn-devel] patch pkcs11 dynamic key id detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Peter Koch <pk@...1082...>, openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

>  So back to my original idea... Use the management interface to prompt
>  the user to select a certificate.

What does that mean for the end-user? If I understand it correctly the
user will need to do the following:
- start tunnel/openvpn
- open webbrowser and select certificate
- enter key (where? webinterface?, cli?)

The thing is that some implementations of middleware (the Belgian eID
middleware, based on opensc) prompts the user with a GUI windows for
entering the password. (at least on MS Windows, not on my mac).
This window is started from the opensc layer and thus independent of
the layer above (openvpn). (please correct me if I'm wrong)

With this situation it really becomes to complex for the end-user:
- start tunnel (place 1)
- open browser select certificate (place2)
- enter passwd in separate window (place 3)
The user has 3 different locations where input is needed.

With my proposed patch, the user has only two different things to do.
- start tunnel
- enter key in cli or GUI window
There are no complex certificate selections, as most of the users
don't even understand what they are. Isn't it the sys/net-admin that
should configure that pkcs11-id or pkcs11-match string?

I liked the principle of the cryptoapicert hook in windows where the
admin enters a part of the string to match. (Unfortunately I can't get
it working on that Windows machine.. weird SSL issue.. but that's
something for another mail )

I plan to work on v2 of my patch to enable the 'match' on either the
DN or the serialised-id. This way it becomes even more flexible and
powerful.
But well, except if there is no hope of seeing this patch in the main
trunk in the future ...

What do you think?

Isn't it also a possibility to include both ways? If yes I think we
should rewrite it a little to prevent duplicate code as much as
possible...

Cheers

Christophe

