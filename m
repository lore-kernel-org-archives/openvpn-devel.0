From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 10 Oct 2015 14:27:45 +0200
Message-ID: <56190441.8060507@...277...>
References: <CAGyAFMVOixa+Qiz_nRjhjgPdrMBvtiiuZ4DqCEUu75TC8u_ffQ@...278...>
	<5362DB19.3000800@...1114...>
	<20140501235033.GW5592@...1818...>
Mime-Version: 1.0
In-Reply-To: <20140501235033.GW5592@...1818...>
Subject: Re: [Openvpn-devel] ipv6 env vars to client scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi Samuel,

I like the idea of patch=20
https://community.openvpn.net/openvpn/attachment/ticket/230/patch, I=20
think ifconfig_ipv6_pool_remote_ip is indeed useful - we use it in our=20
production, too.

Here:

void
+setenv_in6_addr_t (struct env_set *es, const char *name_prefix, struct=20
in6_addr *addr, const bool flags)
+{

"flags" should have type "const unsigned int" instead of "const bool".


Could you also rebase it on top of master - at the moment the first part=20
of socket.c fails to apply.

-Lev


02.05.2014, 01:50, Samuel Thibault kirjoitti:
> David Sommerseth, le Fri 02 May 2014 01:39:05 +0200, a =E9crit :
>> On 17/04/14 14:07, Lev Stipakov wrote:
>>> Hello,
>>>
>>> Are there any plans to support ipv6 env vars in
>>> client-connect/disconnect scripts?
>>>
>>> There are at least 2 tickes on that feature:
>>>
>>> https://community.openvpn.net/openvpn/ticket/230
>>> https://community.openvpn.net/openvpn/ticket/369
>>>
>>> Is there anything that prevents merging any of suggested patches to
>>> the master branch?
>>
>> I don't think I've seen these patches on the mailing list (I'm going thr=
ough
>> the list now).
>
> My patches were sent on 2013 May 24th on openvpn-devel.
>
> Samuel
>
> -------------------------------------------------------------------------=
-----
> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
> Instantly run your Selenium tests across 300+ browser/OS combos.  Get
> unparalleled scalability from the best Selenium testing platform availabl=
e.
> Simple to use. Nothing to install. Get started now for free."
> http://p.sf.net/sfu/SauceLabs
>



