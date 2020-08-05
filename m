From: "Vladislav Grishenko" <themiron@...2010...>
References: <20200805102333.3109-1-themiron@...2010...>
 <202008051154.075Bsv9p086558@...2054...>
In-Reply-To: <202008051154.075Bsv9p086558@...2054...>
Date: Wed, 5 Aug 2020 17:27:45 +0500
Message-ID: <000d01d66b23$d2e48f70$78adae50$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Log serial number of
 revoked certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi, Gert

Thank you.
I'd appreciate if patch could be applied to release/2.4 too, no changes are
required - related code is the same, just hunks offset in ssl_verify.c and
ssl_verify_openssl.c
I've tested 2.4.9 [git:release/2.4/7c428ca19a8df6b9+] with patch on sample
certificates, please refer log is below:

OpenSSL, --crl-verify sample-keys/ca.crl
Wed Aug  5 17:18:49 2020 127.0.0.1:16001 VERIFY ERROR: depth=0,
error=certificate revoked: C=KG, ST=NA, O=OpenVPN-TEST, CN=client-revoked,
emailAddress=me@...430..., serial=3
Wed Aug  5 17:18:49 2020 127.0.0.1:16001 OpenSSL: error:1417C086:SSL
routines:tls_process_client_certificate:certificate verify failed
Wed Aug  5 17:18:49 2020 127.0.0.1:16001 TLS_ERROR: BIO read
tls_read_plaintext error

mbedTLS, --crl-verify sample-keys/ca.crl
Wed Aug  5 17:25:28 2020 127.0.0.1:16001 VERIFY OK: depth=1, C=KG, ST=NA,
L=BISHKEK, O=OpenVPN-TEST, emailAddress=me@...430...
Wed Aug  5 17:25:28 2020 127.0.0.1:16001 VERIFY ERROR: depth=0,
subject=C=KG, ST=NA, O=OpenVPN-TEST, CN=client-revoked,
emailAddress=me@...430..., serial=3: The certificate has been revoked
(is on a CRL)
Wed Aug  5 17:25:28 2020 127.0.0.1:16001 TLS_ERROR: read tls_read_plaintext
error: X509 - Certificate verification failed, e.g. CRL, CA or signature
check failed

touch sample-keys/3, --crl-verify sample-keys/ dir
Wed Aug  5 17:18:12 2020 127.0.0.1:16001 VERIFY OK: depth=1, C=KG, ST=NA,
L=BISHKEK, O=OpenVPN-TEST, emailAddress=me@...430...
Wed Aug  5 17:18:12 2020 127.0.0.1:16001 VERIFY CRL: depth=0, C=KG, ST=NA,
O=OpenVPN-TEST, CN=client-revoked, emailAddress=me@...430..., serial=3
is revoked
Wed Aug  5 17:18:12 2020 127.0.0.1:16001 OpenSSL: error:1417C086:SSL
routines:tls_process_client_certificate:certificate verify failed
Wed Aug  5 17:18:12 2020 127.0.0.1:16001 TLS_ERROR: BIO read
tls_read_plaintext error

--
Best Regards, Vladislav Grishenko

-----Original Message-----
From: Gert Doering <gert@...1296...> 
Sent: Wednesday, August 5, 2020 4:55 PM
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: [PATCH applied] Re: Log serial number of revoked certificate

Your patch has been applied to the master branch.

I have not done much testing, just a test run "make check" on an OpenSSL and
mbedTLS build.

I have not looked into applying it to "release/2.4" - if you think it's
needed, let me know (or if it needs more work because the code has diverged
too much, send a 2.4 patch) - thanks.

commit 992e9cec40539a155afa9eae10502aa62f617965
Author: Vladislav Grishenko
Date:   Wed Aug 5 15:23:33 2020 +0500

     Log serial number of revoked certificate

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20200805102333.3109-1-themiron@...2010...>
     URL:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20642.ht
ml
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering



