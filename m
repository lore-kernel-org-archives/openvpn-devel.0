References: <ZIKZwAKGvWmbJ-kO_eJLJtMC987pVCbt6uMCrILdSuhQ6AcV0SVrQMn1r2xab_2K8ncLE47H_VO9gZqAcCSP6HkcFWXOKTuXXqhRXETdFwU=@protonmail.com>
From: Antonio Quartulli <a@...2181...>
Message-ID: <77250543-ceda-b412-6ff5-8f5ef5f0b3a3@...2181...>
Date: Fri, 23 Apr 2021 09:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <ZIKZwAKGvWmbJ-kO_eJLJtMC987pVCbt6uMCrILdSuhQ6AcV0SVrQMn1r2xab_2K8ncLE47H_VO9gZqAcCSP6HkcFWXOKTuXXqhRXETdFwU=@protonmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: tincantech <tincantech@...2282...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 22/04/2021 23:02, tincantech via Openvpn-devel wrote:
> hi,
> 
> I am requesting that $daemon_pid be added to the --tls-crypt-v2-verify environment.

The environment for --tls-crypt-v2-verify was designed to be extremely
minimal.
Anything concerning tls-crypt verification was designed to be as minimal
as possible.

Indeed, differently from other scripts, the env for tls-crypt-v2 is
created empty and then only a very few variables are added.

Anything that was deemed not necessary for the metadata verification was
not passed.


I can imagine you have a usecase for daemon_pid, but I am sure more
people will have other arguments for other variables as well. Hence the
idea to design something extremely minimal and leave more complex logics
to following (post-auth) steps.


> 
> FTR: $daemon_pid is currently undocumented in all three manuals.

It'd be nice to have such documentation added :-)

Cheers,



-- 
Antonio Quartulli

