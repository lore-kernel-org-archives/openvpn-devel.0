MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
References: <1332616557-15727-1-git-send-email-alon.barlev@...277...>
	<CAOazyz3p-pZ=Sbmomnr2b9431hFxsxjte_P7ucSCAA4gJBpC_Q@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sun, 25 Mar 2012 12:51:55 +0200
Message-ID: <CAP+U6tKTRJ8ybhd9xgyZrj0vDXPFAk+=r=Ai46sUjDsio3bsgw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] build: rename bool->obool
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

Hi Alon,

2012/3/24 Alon Bar-Lev <alon.barlev@...277...>:
> On Sat, Mar 24, 2012 at 9:15 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
>> PPC architectures and conflict with stdbool.h.
>>
>> basic.h defines a type 'bool' that conflicts with the altivec
>> keyword bool which has to be fixed upstream, see bugs[1][2].
>>
>> [1] https://bugs.gentoo.org/show_bug.cgi?id=293840
>> [2] https://bugs.gentoo.org/show_bug.cgi?id=297854

The approach attempted in [2], using stdbool.h, looks far less
intrusive than renaming "bool" to "obool" everywhere, so why did you
choose the latter approach? Jan Scholz's comment #6 [3] sounds like
the right approach to me ...

Cheers
Fabian

3: https://bugs.gentoo.org/show_bug.cgi?id=297854#c6

