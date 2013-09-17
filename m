MIME-Version: 1.0
In-Reply-To: <20130917195350.GL161@...1296...>
References: <CAFHpkQEPogSqK9xbkMa4YYdE9yNSO9Lwj9Tqo-jARB4hrgdYbw@...278...>
	<20130917195350.GL161@...1296...>
Date: Wed, 18 Sep 2013 01:57:55 +0600
Message-ID: <CAFHpkQFBF6EXPfXMV=ePhh3QNMRJuXnh5TjG1bCtKJuOi40Utw@...278...>
From: =?KOI8-R?B?6czY0SD7ydDJw8nO?= <chipitsine@...277...>
Subject: Re: [Openvpn-devel] "unix style line endings" in openvpn-build repo
	?
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

ok, I don't mind about msvc.
but I guess you are wrong about unix style endings. If you setup, for
example, Jenkins on Windows (which is very natural thing to do), so
you want Jenkins to perform git checkout (so called VCS trigger), it
will be CR+LF files. I'd bet that notice "guys, please use cygwin's
git" shouldn't appear in case if line endings would have been unix
style always.

2013/9/18 Gert Doering <gert@...1296...>:
> Hi,
>
> On Wed, Sep 18, 2013 at 12:32:09AM +0600, ???? ??????? wrote:
>> if is it possible to remove "msvc" build subsystem, I think we could
>> switch line endings to "unix style" in repo itself, like that:
>
> a) we can't remove msvc building, because James uses it
> b) the repo does use unix style line endings already
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

