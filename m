MIME-Version: 1.0
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012D1B7431A@...1436...>
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1B7431A@...1436...>
Date: Mon, 7 May 2012 10:33:19 +0300
Message-ID: <CAOazyz0_94OnPTTPfYZBYvA9H6d8rrMKNYY+FpEaUp+KpvHLjQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
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
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Mon, May 7, 2012 at 10:23 AM, Adriaan de Jong <dejong@...1435...> wrote:
>> -----Original Message-----
>> From: Alon Bar-Lev [mailto:alon.barlev@...277...]
>> Sent: zondag 6 mei 2012 18:55
>> To: openvpn-devel@lists.sourceforge.net
>> Subject: [Openvpn-devel] [RFC] Split plugins into their own
>> repositories
>>
>> Hello,
>>
>> Now, I also have the courage to ask one more question regarding
>> build....
>>
>> We currently have:
>> - auth-pam
>> - defer
>> - down-root
>> - examples
>>
>> Distribution wise it will be best to allow admin to install plugins as
>> own package which requires openvpn, allowing select specific plugins,
>> while each has own release cycle and versioning.
>>
>> I already made the openvpn-plugin.h available in /usr/include, so there
>> is no real reason to keep the plugins in openvpn tree, as they can be
>> complied using their own separate build system.
>>
>> for example, if we take RHEL, we can install the following to use the
>> auth-pam plugin:
>>
>> openvpn
>> openvpn-plugin-auth-pam
>>
>> To build plugin we need openvpn-devel.
>>
>> What do you say?
>>
>> BTW: next will be probably to split out the contrib... :)
>>
>> Alon
>>
>
> Aren't we going a little far in the whole splitting business? I though splitting the build system off was already taking it a too far.
>
> These plugin and contrib. directories are directly related to the current version of OpenVPN. Having them in the same tree, especially one that has already been cleaned up by giving it a separate src directory.
>
> My vote therefore goes towards keeping them inline!
>
> Adriaan

Hello Andriaan,

Can you please explain what exactly is business? And what is
relationship between business and number of repositories? And why
business was split?

The only "build" system that was split was the windows PACKAGING which
is not the build system, as both the MSVC build system and the
autotools build system are part of the openvpn repository.

Now, is there any advantage in keeping the windows PACKAGING within
the same repository if its release cycle is totally atomic and
unrelated to openvpn maintenance? Can you please share some thought
with me, I really interested to understand how this lower
productivity?

Same for splitting out the tap-windows driver, I cannot think of any
single argument why this was needed to be within same repository of
openvpn, as it has its own version, release cycle and potential
maintainer. And there are other projects out there that needs only the
tap-windows, so providing own release cycle and installer only make it
more usable.

So before we discuss the benefit of splitting more component, I am
very interested to understand how current process went too far,
meaning productivity of the openvpn project maintenance was damaged.

Regards,
Alon.

