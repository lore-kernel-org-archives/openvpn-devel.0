MIME-Version: 1.0
References: <20230101215109.1521549-5-selva.nair@...277...>
 <20230102194156.1560195-1-selva.nair@...277...>
In-Reply-To: <20230102194156.1560195-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 5 Jan 2023 18:20:01 +0200
Message-ID: <CAGyAFMU30BuPUVyjebLj=JDZaNLzAPkHhb8JGvFt1FHuQCVfkw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Fix signal handling on Windows
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> -    else if (n > 0)
> +    else
>      {
> -        sleep(n);
> +#ifdef _WIN32
> +        win32_sleep(n);
> +#else
> +        if (n > 0)
> +        {
> +            sleep(n);


My understanding is that we want to have interruptible sleep. In this case,
what is the point of calling win32_sleep(0) ? I understand that
management_sleep(0)
is required to service possible management commands even if we don't
need a delay,
but shouldn't it be a no-op without management?

> +void
> +win32_sleep(const int n)
> +{
> +    if (n < 0)
> +    {
> +        return;
> +    }

Why not <= 0 ?

> +    /* Sleep() is not interruptible. Use a WAIT_OBJECT to catch signal */
> +    if (HANDLE_DEFINED(win32_signal.in.read))
> +    {

I would reverse this condition, and do just

    Sleep(n*1000);
    return;

This way we get rid of the indentation level.

> +        time_t expire = 0;
> +        update_time();
> +        expire = now + n;

I would declare and initialize time_t expire after update_time().

> +            DWORD status = WaitForSingleObject(win32_signal.in.read, (expire - now)*1000);
> +            if (win32_signal_get(&win32_signal) || status == WAIT_TIMEOUT)
> +            {
> +                return;
> +            }

Shouldn't we call win32_signal_get() only if status == WAIT_OBJECT_0 ?

Under what circumstances are we supposed to do the waiting again? If
we get a signal, we bail out.
If the wait times out, we bail out. If wait fails, we do Sleep
(although at this point we probably have a bigger issue).

-Lev

