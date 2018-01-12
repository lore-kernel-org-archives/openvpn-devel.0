MIME-Version: 1.0
In-Reply-To: <3ea860bd412bbc9638cb54ade1a85ee08caf1b42.1515775195.git.logout@...260...>
References: <cover.1515775195.git.logout@...260...>
 <3ea860bd412bbc9638cb54ade1a85ee08caf1b42.1515775195.git.logout@...260...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Jan 2018 12:09:41 -0500
Message-ID: <CAKuzo_hVoa=_6yP3mmch4RUpt9Ds-wcukcDZr=pmu_q5qChfRg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] OpenSSL: remove some EVP_PKEY type
 checks
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
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

I will defer to crypto experts for a proper review, but a quick remark

On Fri, Jan 12, 2018 at 11:48 AM, Emmanuel Deloget <logout@...260...> wrote:
> Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
> the same check is also performed in the later.
>
>
...

> +            RSA *rsa = NULL;
> +            DSA *dsa = NULL;
>  #ifndef OPENSSL_NO_EC
> -            else if ((EVP_PKEY_id(pkey) == EVP_PKEY_EC) && (EVP_PKEY_get0_EC_KEY(pkey) != NULL))
> +            EC *ec = NULL;

That looks wrong: do you mean EC_KEY instead of EC?

> +
> +            if ((ec = EVP_PKEY_get0_EC_KEY(pkey)) != NULL)

Selva

