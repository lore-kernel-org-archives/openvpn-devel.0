Message-ID: <26832672787A4D0DAE606EEEE8E19ABF@...1853...>
From: <debbie10t@...277...>
References: <70BE12F3EEB84953AEC765E475A7CA70@...1853...>
	<20150724073910.GH382@...1296...>
Date: Fri, 24 Jul 2015 11:31:41 +0100
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] autoreconf: Unescaped left brace in regex is
	deprecated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi

as the title states the question was with regard to:

[root@...2045... 20150723]# autoreconf -i -v -f
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal --force -I m4
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.

The other information was to show I was working with GIT Master
and the other software versions involved.

I have never seen this error before and wanted to ensure the dev
team were aware that something has been deprecated and may
impact openvpn build in future.

Regards



----- Original Message ----- 
From: "Gert Doering" <gert@...1296...>
To: <debbie10t@...277...>
Cc: <openvpn-devel@lists.sourceforge.net>
Sent: Friday, July 24, 2015 8:39 AM
Subject: Re: [Openvpn-devel] autoreconf: Unescaped left brace in regex is 
deprecated

Hi,

On Thu, Jul 23, 2015 at 11:44:41PM +0100, debbie10t@...277... wrote:
> Openvpn still compiles without noticable errors and
> functions correctly under my variety of test but
> I was wondering if this is important ?

This is a long mail with lots of things in there.  Which messages exactly?

(The autoconf/automake warnings are perl warnings about the code in=20
autoconf/automake, and totally unrelated to OpenVPN)

gert



