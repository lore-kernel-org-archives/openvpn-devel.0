Message-ID: <4FA827CF.20109@...68...>
Date: Mon, 07 May 2012 21:51:43 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1333820547-9672-1-git-send-email-alon.barlev@...277...>
	<CAP+U6tKxU2OjMjeVUuR07dGBh+gdyvB4370+wq3k66=qPfxrPw@...278...>
	<CAOazyz2Cg78qGwU1izJYihcfQvDsQkgP0cDi2Nif4yQQ2gt5Xw@...278...>
In-Reply-To: <CAOazyz2Cg78qGwU1izJYihcfQvDsQkgP0cDi2Nif4yQQ2gt5Xw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: remove C++ comments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 26.04.2012 18:06, schrieb Alon Bar-Lev:
> On Thu, Apr 26, 2012 at 3:33 PM, Fabian Knittel
> <fabian.knittel@...1547...> wrote:
>> Hi Alon,
>>
>> 2012/4/7 Alon Bar-Lev <alon.barlev@...277...>:
>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>>> ---
>>>  src/openvpnserv/openvpnserv.c |    6 +++---
>>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/src/openvpnserv/openvpnserv.c b/src/openvpnserv/openvpnserv.c
>>> index a9a9441..56f5a02 100755
>>> --- a/src/openvpnserv/openvpnserv.c
>>> +++ b/src/openvpnserv/openvpnserv.c
>>> @@ -87,9 +87,9 @@ static HANDLE exit_event = NULL;
>>>  /*
>>>  * Message handling
>>>  */
>>> -#define M_INFO    (0)                                  // informational
>>> -#define M_SYSERR  (MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) // error + system code
>>> -#define M_ERR     (MSG_FLAGS_ERROR)                    // error
>>> +#define M_INFO    (0)                                  /* informational */
>>> +#define M_SYSERR  (MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) /* error + system code */
>>> +#define M_ERR     (MSG_FLAGS_ERROR)                    /* error */
>>>
>>>  /* write error to event log */
>>>  #define MSG(flags, ...) \
>>
>> ACK. Doesn't hurt to be consistent. Are those the only remaining
>> C++-style comments?
> 
> there is one more place I chose to ignore, the service implementation
> is taken from Microsoft SDK sample, and has C++ comments... to remain
> close to the original I left this intact.
> 
>> (Does someone know what C standard we aim at? "C++ comments" would be
>> just fine for C99.)
> 
> Currently openvpn should support C89 based on supported configurations.

Uh, if you rely on recent POSIX revisions you'll need C99 anyways
(Solaris 10 used to enforce that, but I've quit looking at Solaris now
that Oracle locked it up.)



