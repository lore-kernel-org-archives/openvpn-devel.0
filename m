MIME-Version: 1.0
In-Reply-To: <b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
	<b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
From: Olivier W <olivierw.ml@...277...>
Date: Mon, 13 Feb 2017 21:55:00 +0100
Message-ID: <CAOAUwZGs4934tC9P3zvmrN6qp-L9vkSMOi3_UwXT4Q7NCvdp5w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
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
To: openvpn-devel@lists.sourceforge.net

Hello David,

2017-02-13 20:37 GMT+01:00 David Sommerseth <openvpn@...2080...>:
>
> smtpsslcertpath needs to point at a CA certificate which issued the SMTP
> server certificate.  You can easily verify that things are correct by
> grabbing the server certificate using openssl:
>
>     $ openssl s_client -connect $SMTP_SERVER:$PORT -starttls smtp
>
> Copy the certificate blob printed to stdout to a file.  Then take your
> CA certificate (including full chain in a single file, where the root CA
> certificate is the last one in file) and run this command:
>
>     $ openssl verify -CAfile $CA_CERT_CHAIN $SERVER_CERT
>
> The output should display the file of the server certificate and ": OK".

Thanks for your help, but I still can't use GMail on port 587 (but
everything is OK on port 465).
In my .gitconfig, I have "smtpsslcertpath = /etc/ssl/cert.pem" and the
.pem file exists, installed by the package "ca_root_nss" on FreeBSD.

So, I tried "openssl s_client -connect smtp.gmail.com:587 -starttls
smtp", copying the content from: "-----BEGIN CERTIFICATE-----" to
"-----END CERTIFICATE-----" in a file, but running "openssl verify
-CAfile /etc/ssl/cert.pem gmail.cert" gives:
"gmail.cert: C = US, ST = California, L = Mountain View, O = Google
Inc, CN = smtp.gmail.com
error 20 at 0 depth lookup:unable to get local issuer certificate"

I also tried on Debian and I'm getting the same error. Same thing with
Hotmail on "smtp.live.com:587".

Well, as long as I can use the other port with SSL, it's ok :-)

>> That's a not exactly helpful error message... :( - I tend to just turn
>> off SSL on stuff that goes to public mailing lists anyway if it causes
>> issues...
>
> OpenSSL errors requires quite some efforts to get used to.  And in
> addition the git-send-email errors on top doesn't always make life easier.

I've just tried git-send-email with "--smtp-debug=1" and the error
isn't much useful, I'm getting:
"...
Net::SMTP=GLOB(0x8048189a8)<<< 250 SMTPUTF8
Net::SMTP=GLOB(0x8048189a8)>>> STARTTLS
Net::SMTP=GLOB(0x8048189a8)<<< 220 2.0.0 Ready to start TLS
Net::SMTP=GLOB(0x8048189a8)>>> STARTTLS
Net::SMTP: Net::Cmd::getline(): unexpected EOF on command channel:
Connection reset by peer at /usr/local/libexec/git-core/git-send-email
line 1371.
STARTTLS failed!  at /usr/local/libexec/git-core/git-send-email line 1371."

>>> BTW: sorry about the previous email: "[SPAM] [PATCH] Fix building with
>>> LibreSSL 2.5.1 by cleaning a hack." :-/ I'm trying to not post anymore
>>> buggy email here.
>
> No worries!  As long as you don't spam us completely with non-sense, we
> can handle a few misfires ;-)

;-)

Best Regards,
Olivier

