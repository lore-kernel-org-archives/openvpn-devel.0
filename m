Message-ID: <44D994C7C0C34D08AC086A6C613D5697@...1853...>
From: <debbie10t@...277...>
References: <70BE12F3EEB84953AEC765E475A7CA70@...1853...>
	<20150724073910.GH382@...1296...>
	<26832672787A4D0DAE606EEEE8E19ABF@...1853...>
	<20150724113420.GJ382@...1296...>
Date: Fri, 24 Jul 2015 12:57:21 +0100
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

OK .. thanks for clearing that up.

----- Original Message ----- 
From: "Gert Doering" <gert@...1296...>
To: <debbie10t@...277...>
Cc: "Gert Doering" <gert@...1296...>; 
<openvpn-devel@lists.sourceforge.net>
Sent: Friday, July 24, 2015 12:34 PM
Subject: Re: [Openvpn-devel] autoreconf: Unescaped left brace in regex is 
deprecated

Hi,

On Fri, Jul 24, 2015 at 11:31:41AM +0100, debbie10t@...277... wrote:
> Unescaped left brace in regex is deprecated, passed through in regex; mar=
ked
> by <-- HERE in m/\${ <-- HERE ([^ \t=3D:+{}]+)}/ at /usr/bin/automake line
> 3936.
[..]
> I have never seen this error before and wanted to ensure the dev
> team were aware that something has been deprecated and may
> impact openvpn build in future.

This is because the code in /usr/bin/automake is old-style perl.

It has nothing to do whatsoever with OpenVPN.

gert 


