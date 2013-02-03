From: Heiko Hund <heiko.hund@...1489...>
Date: Sun, 3 Feb 2013 11:21:08 +0100
Message-ID: <2816767.fsHXbIGh7R@...1524...>
In-Reply-To: <510D432C.1060107@...1114...>
References: <1358854613-7150-1-git-send-email-heiko.hund@...1489...>
	<510D432C.1060107@...1114...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] ignore UTF-8 byte order mark
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Saturday 02 February 2013 17:47:40 David Sommerseth wrote:
> Wouldn't this approach solve it in an easier way?
> 
>        int offset = 0;
>        if (line_num == 1 && strncmp (line, "\xEF\xBB\xBF", 3) == 0)
>           offset = 3
> 
>        if (parse_line (line+offset, p, SIZE (p), file, line_num ....
> 
> Should be safer as you don't need care about proper NULL termination of
> the buffer.

Although fgets(3) is supposed to always \0 terminate the buffer I like your 
approach better, as it's more lightweight. Will send an updated version.

Heiko

