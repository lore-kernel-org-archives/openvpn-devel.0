Message-ID: <4FE97362.709@...515...>
Date: Tue, 26 Jun 2012 11:31:30 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAAhp1KBzkQyGqFPWqT5N0kKXsGvBLj8KLsZY_C9wWnuwFAQHdQ@...278...>
	<20120626063546.GQ1059@...1296...>
In-Reply-To: <20120626063546.GQ1059@...1296...>
Subject: Re: [Openvpn-devel] After compiling openVPN 2.3 alpha. I get R6034
 error on execution
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Tue, Jun 26, 2012 at 11:16:31AM +0530, Gauri Bhave wrote:
>> I downloaded the openvpn-2.3-alpha1.zip from openvpn.net and successfully
>> compiled it for windows using the Python build system. But when I run the
>> application I get following runtime error for openvpn.exe. R6034 An
>> application has made an attempt to load the c runtime library incorrectl=
y.
>> Please contact application support team for more information.
> Any specific reason you're not using Samuli's pre-built windows binary?
>
> To answer your question: no idea whether the Python build system currently
> works or not - it's not the preferred build system for 2.3, that is
> "cross building with MinGW64 from linux", or building with cygwin/mingw
> on windows.  Samuli knows more details.
>
> gert
Unless you have specific reason not to, I'd try the new "openvpn-build"
buildsystem:

<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem>

It's possible to build using Visual Studio 2010 (Express) or later, but
I prefer cross-compiling on *NIX. You need to fetch sources from Git
until we get 2.3-alpha2 out later this week:

<https://github.com/OpenVPN>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


