References: <20181010083731.31132-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2d686446-ed45-00aa-f96f-6a374bb0c108@...1856...>
Date: Wed, 10 Oct 2018 10:47:09 +0200
MIME-Version: 1.0
In-Reply-To: <20181010083731.31132-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] buffer_list: add functions documentation
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 10-10-18 10:37, Antonio Quartulli wrote:
> bufferlist_* functions have no documentation whatsoever and the name is
> not always enough to fully understand what the function is doing.
> For this reason and for the sake of having better documented code, add
> function doc in buffer.h.

Very good, thanks for documenting this!

> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> Some doc might be extended and some might be unecessary.
> Still I think it is good to start having doc for more helper functions
> we have around.
> 
>  src/openvpn/buffer.h | 67 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index cb9e9dff..dbc5bfc3 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -1091,26 +1091,93 @@ struct buffer_list
>      int max_size;            /* maximum size list should grow to */
>  };
>  
> +/**
> + * Allocate an empty buffer list of capacity \c max_size.
> + *
> + * @param max_size  the capacity of the list to allocate
> + *
> + * @return the new list
> + */
>  struct buffer_list *buffer_list_new(const int max_size);
>  
> +/**
> + * Frees a buffer list and all the buffers in it.
> + *
> + * @param ol    the list to free
> + */
>  void buffer_list_free(struct buffer_list *ol);
>  
> +/**
> + * Checks if the list is valid and non-empty
> + *
> + * @param ol    the list to check
> + *
> + * @return true iff \c ol is not NULL and contains at least one buffer
> + */
>  bool buffer_list_defined(const struct buffer_list *ol);
>  
> +/**
> + * Empty the list \c ol and frees all the contained buffers
> + *
> + * @param ol    the list to reset
> + */
>  void buffer_list_reset(struct buffer_list *ol);
>  
> +/**
> + * Allocates and appends a new buffer containing \c str as data to \c ol
> + *
> + * @param ol    the list to append the new buffer to
> + * @param str   the string to copy into the new buffer
> + */
>  void buffer_list_push(struct buffer_list *ol, const char *str);
>  
> +/**
> + * Allocatea and appends a new buffer containing \c data of length \c size.

Typo: allocate*s*.

> + *
> + * @param ol    the list to append the new buffer to
> + * @param data  the data to copy into the new buffer
> + * @param size  the length of \c data to copy into the buffer
> + *
> + * @return the new buffer
> + */
>  struct buffer_entry *buffer_list_push_data(struct buffer_list *ol, const void *data, size_t size);
>  
> +/**
> + * Retrieve the head buffer
> + *
> + * @param ol    the list to retrieve the buffer from
> + *
> + * @return a pointer to the head buffer or NULL if the list is empty
> + */
>  struct buffer *buffer_list_peek(struct buffer_list *ol);
>  
>  void buffer_list_advance(struct buffer_list *ol, int n);
>  
>  void buffer_list_pop(struct buffer_list *ol);
>  
> +/**
> + * Aggregates as many buffers as possible from \c bl in a new buffer of maximum
> + * length \c max_len .
> + * All the aggregated buffers are removed from the list and replaced by the new
> + * one, followed by any additional (non-aggregated) data.
> + *
> + * @param bl    the list of buffer to aggregate
> + * @param max   the maximum length of the aggregated buffer
> + */
>  void buffer_list_aggregate(struct buffer_list *bl, const size_t max);
>  
> +/**
> + * Aggregates as many buffers as possible from \c bl in a new buffer
> + * of maximum length \c max_len . \c sep is written after
> + * each copied buffer (also after the last one). All the aggregated buffers are
> + * removed from the list and replaced by the new one, followed by any additional
> + * (non-aggregated) data.
> + * Nothing happens if \c max_len is not enough to aggregate at least 2 buffers.
> + *
> + * @param bl        the list of buffer to aggregate
> + * @param max_len   the maximum length of the aggregated buffer
> + * @param sep       the separator to put between buffers during aggregation
> + */
>  void buffer_list_aggregate_separator(struct buffer_list *bl,
>                                       const size_t max_len, const char *sep);
>  
> 

Apart from the typo, this looks good.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

