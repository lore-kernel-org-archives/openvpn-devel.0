MIME-Version: 1.0
In-Reply-To: <20170213083137.GK93896@...1296...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
From: Olivier W <olivierw.ml@...277...>
Date: Mon, 13 Feb 2017 18:46:11 +0100
Message-ID: <CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
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

Hello Gert,

2017-02-13 9:31 GMT+01:00 Gert Doering <gert@...1296...>:
> Look at "git rebase --interactive", which will enable you to squash
> three commits into a single one.  Then you can use "git commit --amend"
> to work on the (combined) commit message until you're happy with it.

Thanks a lot. I've finally squashed my commits, pushed to github.

Now I'm fighting with git which doesn't want to use gmail's smtp
server to send the email. My .gitconfigure file is similar to:
https://git-scm.com/docs/git-send-email#_example and I've added
"smtpsslcertpath = /etc/ssl/cert.pem" but I'm getting this error:
"STARTTLS failed!  at /usr/local/libexec/git-core/git-send-email line
1371."
I'm currently searching for a solution.

BTW: sorry about the previous email: "[SPAM] [PATCH] Fix building with
LibreSSL 2.5.1 by cleaning a hack." :-/ I'm trying to not post anymore
buggy email here.

Best Regards.

