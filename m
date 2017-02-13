MIME-Version: 1.0
In-Reply-To: <20170213175000.GU93896@...1296...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
From: Olivier W <olivierw.ml@...277...>
Date: Mon, 13 Feb 2017 19:47:02 +0100
Message-ID: <CAOAUwZFZGD7C-4SjQYWdF2THgqfSaT5ZcHYL7ch_yDHrghfP4A@...278...>
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hey :-)

2017-02-13 18:50 GMT+01:00 Gert Doering <gert@...1296...>:
> That's a not exactly helpful error message... :( - I tend to just turn
> off SSL on stuff that goes to public mailing lists anyway if it causes
> issues...

Thanks. I also tried without SSL, but then I had messages about git
not understanding "AUTH" :-/
Finally, for gmail, it's working with:
smtpEncryption = ssl
smtpServerPort = 465
instead of tls/587

> I've created my share of weird git e-mails in the past :-) - so what I've
> started to do is "send the mail to myself" (if possible, on a different
> account) and then verify if the result is what I want to see...

Yes, I guess many people struggle with the email configuration :-) I
had tried to first send to my personal email address and it went well,
but I'm not sure how it worked since I didn't have anything related to
SMTP configuration in ".gitconfig".

Finally, I think it's now OK :-)

Best Regards,
Olivier

