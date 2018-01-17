MIME-Version: 1.0
In-Reply-To: <20180116082652.GJ69387@...1296...>
References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
 <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
 <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
 <CAKuzo_j6Uuw8minumYHECmqtE9ocvrzGtO0_3FUcGnNy4q3Bqw@...278...>
 <CAKh=nwGDv2fKJ6STqYthwpH+1SkztkLj1=KH4MWJ58ifc_byog@...278...>
 <20180116082652.GJ69387@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 17 Jan 2018 13:16:56 +0100
Message-ID: <CAA1AbxLqiVhodTpNzX4qdgx3w8tWaCVpJCXHQRnfzFNXiKa9TQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] OpenSSL: remove some EVP_PKEY
 type checks
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
To: Gert Doering <gert@...1296...>
Cc: Emmanuel Deloget <logout@...260...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 15 January 2018 at 23:33, Emmanuel Deloget <logout@...260...> wrote:
> For the variables outside the ifs, the next C standard should allow us to
> write something like:
>
> if ((RSA *rsa = EVP_PKEY_get0_RSA(pkey)) != NULL) {

Yeah, such a shame that this didn't make it into C11.  Scoping a
variable to an if block is often useful.  If only for error checking
like if(int err = foo()) { handle error }.  Anyway, we can't have it
:(

On 16 January 2018 at 09:26, Gert Doering <gert@...1296...> wrote:
> On Tue, Jan 16, 2018 at 01:56:11AM +0100, Emmanuel Deloget wrote:
>> 3) rework it as proposed in the patch
>>
>> RSA *rsa = NULL;
>> if ((rsa = EVP_PKEY_get0_RSA(pkey)) != NULL) { ... }
>
> I do not particularily like assignments in if() clauses, especially when
> the variable is declared right above it.  So if we go for (3), my
> favourite would be
>
> RSA *rsa = EVP_PKEY_get0_RSA(pkey);
> if (rsa != NULL) { ... }
>
>
> but this is just a side remark.  The question on "1, 2 or 3" I'll defer
> to you folks that are maintaing this code (Steffan and Selva, mostly :) ).

This indeed looks a bit better that initializing to NULL if we're
going to take the variables outside the scope.

Seems I've been overruled by majority regarding the way to go, and
with the suggestion from cron2 taken into account I think 3 is the way
to go.

-Steffan

