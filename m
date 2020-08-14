MIME-Version: 1.0
References: <98f65e22-a66c-aeea-f705-ad5a0f7a2e28@...1227...>
 <20200814171204.22289-1-themiron@...2010...>
 <18c95bb9-408c-a608-fd2c-9f8b5f6f88eb@...1227...>
In-Reply-To: <18c95bb9-408c-a608-fd2c-9f8b5f6f88eb@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 14 Aug 2020 14:22:05 -0400
Message-ID: <CAKuzo_iRjG_pEqjYsaKNniL8LuZ1EL+ok-6BS8Ys0xnOaEwsXw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Allow management to kill client
 instances by CN wildcard
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Fri, Aug 14, 2020 at 1:36 PM Arne Schwabe <arne@...1227...> wrote:
>
> Am 14.08.20 um 19:12 schrieb Vladislav Grishenko:
> > In case of some permanent part of common name (ex. domain) and/or
> > long complex common name consisting of multiple x509 fields, it's
> > handly to kill client instances via management interface with just
> > prefix of common name, not by exact match only.
> >
> > Patch allows to use asterisk as wildcard placeholder in the last
> > trailing symbol of kill command parameter.
> > Single asterisk - empty prefix would be too greedy and can be too
> > harmful, therefore not allowed. Wildcards in the middle of
> > parameter string are not supported to keep the the things simple at the moment.
> >
> > v2: fine tune comments
> >
>
> Thanks for v2,
>
> Acked-By; Arne Schwabe <arne@...1227...>

'*' is an allowed character in x509 common name unless we explicitly
forbid it. So killing a client with name ending in * would get tricky
if not impossible without side effects.

Selva

