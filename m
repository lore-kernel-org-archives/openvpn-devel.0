MIME-Version: 1.0
Date: Wed, 18 Sep 2013 00:32:09 +0600
Message-ID: <CAFHpkQEPogSqK9xbkMa4YYdE9yNSO9Lwj9Tqo-jARB4hrgdYbw@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: [Openvpn-devel] "unix style line endings" in openvpn-build repo ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello!

if is it possible to remove "msvc" build subsystem, I think we could
switch line endings to "unix style" in repo itself, like that:


https://github.com/chipitsine/openvpn-build/blob/master/.gitattributes


it will work under Linux and cygwin (just tryed it), no matter which
"git" command to use, cygwin's one or windows git (there's special
note on cygwin checkout
https://community.openvpn.net/openvpn/wiki/SettingUpGenericBuildsystem
: "If you're building using Cygwin on Windows, it's best to configure
Git not to translate LF to CR/LF. For this reason it's probably best
to use Cygwin's Git." ) Why to have special note, when it could be
done using .gitattributes ?

or, even if we want to keep "msvc" build subsystem, we can manage that
by moving .gitattributes deeper to "generic" subfolder.

Cheers,
Ilya Shipitsin

