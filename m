Message-ID: <5358DBF2.606@...515...>
Date: Thu, 24 Apr 2014 12:40:02 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...>
	<20140423081058.GJ16637@...1296...>	<53579C5D.5000902@...1435...>
	<5357DDFC.2010401@...1901...>	<53581D43.6060501@...1856...>
	<53584B0C.8020209@...1901...>	<20140424070116.GN16637@...1296...>
	<5358C5C0.6090007@...1901...> <20140424081727.GO16637@...1296...>
In-Reply-To: <20140424081727.GO16637@...1296...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Timothe Litt <litt@...1901...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Thu, Apr 24, 2014 at 04:05:20AM -0400, Timothe Litt wrote:
>>> Uh, this is a double misinformation :-)
>> It's good to know that cross-compiling is an option, though=20
>> cross-debugging (e.g. with an interactive debugger) can be an adventure =
too.
>>
>> Source of my comment was:
>>
>> http://community.openvpn.net/openvpn/wiki/BuildingOnWindows, which says
>>> his new build system allows building OpenVPN on Windows more easily,=20
>>> but some parts of the build may r*equire a commercial version of the=20
>>> Visual Studio development environment.*
>>> /Visual Studio 2008 Professional/is used to build OpenVPN on Windows.=20
>>> Note that the free Express edition might not work.
>>> Full installation installs*/x86 cross-tools/*which *may cause nasty,=20
>>> hard to debug issues*.
>> (The professional tools are > $1,000 US, which is not in my budget.)
>>
>> You may want to reword that after validating your comment.  M$'s name=20
>> for the 'free' tools is 'express edition'.  The license terms vary based=
=20
>> on M$'s whims, the current statement is:
>>> http://www.visualstudio.com/products/visual-studio-express-vs
>>> Visual Studio Express products are available at no charge and may be=20
>>> used for commercial, production usage subject to the license terms=20
>>> provided with each product. For example, you can use Express for=20
>>> Windows to create apps that you can then submit for sale in the=20
>>> Windows Store.
> Yeah, I think that page needs clarification (I think you need the commerc=
ial
> edition to do code signing, which is not strictly required if you use
> the pre-signed tap driver bundle), *and* it needs a pointer to the other
> build system page.
>
Added a big fat warning to the top of the page and a pointer to current
documentation. Visual Studio Express also works for driver signing - I
know it because I built tap-windows6 with it a while back with no issues.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


