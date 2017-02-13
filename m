MIME-Version: 1.0
In-Reply-To: <CAKuzo_gwjVdfLbqAQH=4PyvKU2Hha6cd3dJZGkRBTkDTCiB7aQ@...278...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
	<b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
	<CAOAUwZGs4934tC9P3zvmrN6qp-L9vkSMOi3_UwXT4Q7NCvdp5w@...278...>
	<CAKuzo_gwjVdfLbqAQH=4PyvKU2Hha6cd3dJZGkRBTkDTCiB7aQ@...278...>
From: Olivier W <olivierw.ml@...277...>
Date: Tue, 14 Feb 2017 00:12:34 +0100
Message-ID: <CAOAUwZEnuY6_m6Rt8T0=APi_eF-FHRy89+=eSY2svbbGq+D1kg@...278...>
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello Selva,

2017-02-13 22:34 GMT+01:00 Selva Nair <selva.nair@...277...>:
> On Debian jessie, the following .gitconfig works fo me.
>
> [sendemail]
>           smtpEncryption = tls
>           smtpServer = smtp.gmail.com
>           smtpUser = user.name@...277...
>           smtpServerPort = 587
>
> No smtpsslcertpath specified, I suppose it verifies the cert using
> /etc/ssl/certs as the capath, which is the default.

Thanks! Your configuration is what I tried, from git-send-email doc's:
https://git-scm.com/docs/git-send-email#_use_gmail_as_the_smtp_server
I've just tested on Debian and I've been able to send an email with
TLS, so the problem isn't my git or gmail setup.
It could be a FreeBSD only issue, I see they have a patched version of
git-send-email because Net::SMTP::SSL is deprecated.

> Possibly your /etc/ssl/cert.pem is to blame? I do not have such a file, so
> no idea what it contains.

My /etc/ssl/cert.pem file contains all root certificates provided by
Mozilla NSS project, it should be valid.
I'll ask FreeBSD users if they can successfully use TLS with
git-send-email and if not I'll try to debug the script.

Best Regards,
Olivier

