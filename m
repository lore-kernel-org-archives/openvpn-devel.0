Subject: Re: [Openvpn-devel] psw in pem_passphrase_callback() static or not?
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1092082133.1735@...41...>
In-Reply-To: <Pine.LNX.4.60.0408092121530.27324@...210...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Aug  9 13:09:04 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

Mathias Sundman <mathias@...209...> said:

> When i first looked at the pem_passphrase_callback() function in ssl.c, I 
> though that the intention was to save the passphrase so the key could be 
> reloaded after a ping-restart, because you use:
> 
> static char passbuf[256];
> 
> So, I was surprised when my GUI now asked me for the passphrase a second 
> time (after a ping-restart).
> 
> A closer look at the function revealed that you do a CLEAR(passbuf) 
> before returning.

Yes, the intention is to only hold the password long enough to give it to
OpenSSL, when it calls pem_password_callback.

But the function is written in such a way that by not doing the
CLEAR(passbuf), the password will be cached across restarts.  Also
--persist-key might prevent OpenSSL from calling pem_password_callback again
on restart.

It might be useful to change this behavior to cache by default, and then have
an option to disable the caching.  In general, OpenVPN tries not to cache
sensitive data in virtual memory for longer than necessary.

> So, I just wonder, was the intention to save the passphrase or not? If 
> not, why do declare passbuf as static?

It's static because pem_password_callback is called twice.  Once to get the
password from stdin (called from options.c), and then once to return it to
OpenSSL (called from inside OpenSSL).

> Also, is it safe todo
> if (!strlen (passbuf)) 
> when passbuf has not get been assigned any string?

Yes, statics are guaranteed to be zeroed on program startup (unlike automatics).

James


