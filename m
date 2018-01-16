MIME-Version: 1.0
In-Reply-To: <CAFHpkQG9Y4NYnv0ACSj72dNwVpjRggBXvBHMoOwUMnhdVBnL+w@...278...>
References: <CAKuzo_gBhwmAkc8EpaE62NpEhQcGPHkASesiurnF9pcghuv2tA@...278...>
 <CAFHpkQG9Y4NYnv0ACSj72dNwVpjRggBXvBHMoOwUMnhdVBnL+w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Jan 2018 12:38:03 -0500
Message-ID: <CAKuzo_jSURqxSnFWHetd_4yW9ieMzVWZ1fg_xKKYa8dj0gWiCg@...278...>
Subject: Re: [Openvpn-devel] travis builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jan 16, 2018 at 3:16 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>
> 2018-01-15 22:28 GMT+05:00 Selva Nair <selva.nair@...277...>:
>>
>> Hi,
>>
>> Out of the 12 or so jobs we have in the travis build matrix a few
>> sometime fail with "write error" (happened a number of times for some
>> local feature branches). On restarting only the failed jobs, one by
>> one, they succeed indicating possible resource starvation?
>>
>> Is there anything one can do to avoid this?
>>
>> Thanks,
>>
>> Selva
>
> it started to happen after travis-ci image was updated to
> clang-5.0, somehow it does not work well with ccache (that's why
> we removed ccache recently)

Indeed, on removing ccache builds do not error anymore. Thanks.

Selva

