Message-ID: <459DB400.2000602@...334...>
Date: Fri, 05 Jan 2007 04:12:16 +0200
From: Faidon Liambotis <paravoid@...334...>
MIME-Version: 1.0
Subject: [Openvpn-devel] client-cert-not-required == client-cert-do-not-check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello again,
While fiddling with the OpenVPN code for the patch -look at my other
mail- I noticed the following:
When a server specifies client-cert-not-required and the client passes a
certificate, the server does not check this certificate for validity,
i.e. no trust verification (signed by the CA, not in a CRL etc.), no
tls-remote/ns-cert-type/tls-verify handling.
Right now there is a conditional that calls
SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | 	
			 SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
			 verify_callback);
when client-cert-not-required is not set and does nothing but warn when
it's set in the options.

I think that the proper thing to do would be to alter the behavior and call
SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER, verify_callback);
when the option is passed to OpenVPN and keep the current behavior for
the other case.

Is there a reason not to?
I can think of a reason to do that: allow a server that either accepts a
username/password _or_ a valid certificate -- to allow a migration for
example. This of course would need a clever hack with
auth-user-pass-verify/tls-verify scripts or may be a new environmental
variable TLS_VERIFIED.

Another reason to do it is because it's the obvious thing to do:
-not-required doesn't mean -do-not-check/-ignored, it means "I will not
fail if you don't provide it but I will fail if provide one that I can't
verify", IMHO.

Comments?

Regards,
Faidon

