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
Date: Tue, 14 Feb 2017 20:32:42 +0100
Message-ID: <CAOAUwZHAuSdL6q5z40maNPCQQmN0715c1+go0NNmPAvmJZwkFw@...278...>
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

Hello,

So, finally I've been able to use "git-send-email" with TLS. The
problem was a patch used by FreeBSD.

If there are any FreeBSD users on this list or for the curious, you
can find more information on FreeBSD's bugtracker:
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=214335#c10

Or if someday you update git, Perl or one of its components
(Net::SMTP::SSL is deprecated) and "git-send-email" break, you may
find a way to solve the problem in the link posted above.

HTH!
Olivier

