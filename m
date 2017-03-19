Date: Sun, 19 Mar 2017 17:21:46 +0100 (CET)
Message-Id: <201703191621.v2JGLkEn031699@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1489612820-15284-1-git-send-email-steffan@...1856...>
References: <1489612820-15284-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Be less picky about keyUsage
	extensions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  While I'm certainly not the authority when it comes to crypto
library innards, after the discussion we had on IRC, I'm fine with
the changes - and testing against our own corp CA (which did not work
with --remote-cert-tls server before, because it had "too many bits"
set) it works now - that is, "remote-cert-tls server" works, ".. client" 
fails (set on the client).

The code change match the description, and the behaviour observed 
for "the SSL library will check" also matches (I have not tried creating 
a cert without ku/eku to see what happens then, but trust Steffan to have 
done so).

The default error messages *could* be a bit more helpful, though...

Sun Mar 19 17:07:17 2017 TLS_ERROR: read tls_read_plaintext error: X509 - Certificate verification failed, e.g. CRL, CA or signature check failed

.. but increasing debug to --verb 2 shows all the details:

Sun Mar 19 17:07:45 2017 Validating certificate key usage
Sun Mar 19 17:07:45 2017 VERIFY KU OK
Sun Mar 19 17:07:45 2017 Validating certificate extended key usage
Sun Mar 19 17:07:45 2017 ++ Certificate has EKU (str) TLS Web Server Authentication, expects TLS Web Client Authentication
Sun Mar 19 17:07:45 2017 ++ Certificate has EKU (oid) 1.3.6.1.5.5.7.3.1, expects TLS Web Client Authentication
Sun Mar 19 17:07:45 2017 VERIFY EKU ERROR

(intentional error)


Tested both for OpenSSL and mbedTLS builds.

Patch has been applied to the master and release/2.4 branch.

commit 92a5b9fb76cbb7f43a6aa86994ff559f06c55c7a (master)
commit 60b23236329e6921729f51e7689042a29c794a6b (release/2.4)
Author: Steffan Karger
Date:   Wed Mar 15 22:20:20 2017 +0100

     Be less picky about keyUsage extensions

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1489612820-15284-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14265.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


