References: <ZIKZwAKGvWmbJ-kO_eJLJtMC987pVCbt6uMCrILdSuhQ6AcV0SVrQMn1r2xab_2K8ncLE47H_VO9gZqAcCSP6HkcFWXOKTuXXqhRXETdFwU=@protonmail.com>
 <77250543-ceda-b412-6ff5-8f5ef5f0b3a3@...2181...>
 <cs3V6YWogR5xlLJlMXU86uQJ9o2kLYY-Wk48M39jut0c_pdxHDdC_D7fBtq-jCG1GyifsKeLwi0T75zJAR0cz55TFC2vVKqXS-4L32EFpT0=@protonmail.com>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ca5bff69-078c-5707-70a6-0b65a60243a5@...2181...>
Date: Fri, 23 Apr 2021 14:22:19 +0200
MIME-Version: 1.0
In-Reply-To: <cs3V6YWogR5xlLJlMXU86uQJ9o2kLYY-Wk48M39jut0c_pdxHDdC_D7fBtq-jCG1GyifsKeLwi0T75zJAR0cz55TFC2vVKqXS-4L32EFpT0=@protonmail.com>
Content-Language: en-US
Subject: Re: [Openvpn-devel] --tls-crypt-v2-verify env $daemon_pid
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: tincantech <tincantech@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 23/04/2021 14:16, tincantech wrote:
> Hi,
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Friday, 23 April 2021 08:12, Antonio Quartulli <a@...2181...> wrote:
> 
>> Hi,
> 
>> On 22/04/2021 23:02, tincantech via Openvpn-devel wrote:
> 
>>> hi,
>>> I am requesting that $daemon_pid be added to the --tls-crypt-v2-verify environment.
> 
>> The environment for --tls-crypt-v2-verify was designed to be extremely
>> minimal.
>> Anything concerning tls-crypt verification was designed to be as minimal
>> as possible.
> 
>> Indeed, differently from other scripts, the env for tls-crypt-v2 is
>> created empty and then only a very few variables are added.
> 
>> Anything that was deemed not necessary for the metadata verification was
>> not passed.
> 
> I understand your reasoning, however, in the case of daemon_pid would you not
> consider the process to be "more secure" if openvpn *does* provide the PID in
> the environment, rather than have the script read the PID from a file?
> 
> Having to configure openvpn to write the PID and then read the PID is two steps
> which can introduce user bound misconfiguration errors.

we can't control what the user does with the script - he could do
anything wrong and ugly, but we can't just implement shortcuts for them, no?

> 
>> I can imagine you have a usecase for daemon_pid, but I am sure more
>> people will have other arguments for other variables as well. Hence the
>> idea to design something extremely minimal and leave more complex logics
>> to following (post-auth) steps.
> 
> I reviewed all the other variables for inclusion viability and, with the
> exception of "untrusted_ip / untrusted_ip6", I came to the conclusion that
> the *only* variable which does come with a genuine security bonus is daemon_pid.
> (As outlined in my previous comment)
> 
> As for untrusted_ip*, it definitely could be useful to --tls-crypt-v2-verify
> but I'm not asking for that here.  Perhaps on reading this other members will
> see how it can be of benefit to the scripts versatility..
> (The same goes for untrusted_port but that seems less useful over all)
> 
> I would also quote that old, old expression "Security through Obscurity"
> https://en.wikipedia.org/wiki/Security_through_obscurity

It's not security through obscurity here, but it's about keeping the
code that leads to the tls-crypt-v2-verify call as minimal as possible.


This said, what is deamon-pid useful for in the tls-crypt-v2-verify
script? Maybe a clear usecase with pro and cons could help understanding
where this need is coming from.


> 
> 
>>> FTR: $daemon_pid is currently undocumented in all three manuals.
> 
>> It'd be nice to have such documentation added :-)
> 
> I hope that your not suggesting that I provide documentation for something
> which you then refuse to allow me to use ? ;-)

I thought the documentation could be useful for the other scripts.


Regards,

> 
> Not only but also, "you give a little, you get a little" :D
> 
> In conclusion, I request that OpenVPN review their earlier decision to be so
> *cruelly frugal* to --tls-crypt-v2-verify, on this one occasion.
> 
> Thanks for your informed and collective consideration,
> R
>

-- 
Antonio Quartulli

