--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-08-28 00:33:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16601)
-- Name: dropdown_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dropdown_menu (
    id integer NOT NULL,
    title character varying,
    slug character varying,
    parent_id integer,
    menu_order integer
);


ALTER TABLE public.dropdown_menu OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16604)
-- Name: dropdown_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dropdown_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dropdown_menu_id_seq OWNER TO postgres;

--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 222
-- Name: dropdown_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dropdown_menu_id_seq OWNED BY public.dropdown_menu.id;


--
-- TOC entry 217 (class 1259 OID 16565)
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    id integer NOT NULL,
    name character varying,
    endpoint character varying,
    children character varying,
    remarks character varying,
    "order" integer
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16568)
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_id_seq OWNER TO postgres;

--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 218
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.menu_id_seq OWNED BY public.menu.id;


--
-- TOC entry 224 (class 1259 OID 16614)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    discount_price numeric(10,2),
    image_url text NOT NULL,
    category_id integer,
    stock integer DEFAULT 0,
    rating numeric(2,1) DEFAULT 0.0,
    reviews_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16613)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 223
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- TOC entry 219 (class 1259 OID 16577)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying,
    email character varying,
    password character varying,
    role integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16580)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4834 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4658 (class 2604 OID 16605)
-- Name: dropdown_menu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dropdown_menu ALTER COLUMN id SET DEFAULT nextval('public.dropdown_menu_id_seq'::regclass);


--
-- TOC entry 4656 (class 2604 OID 16569)
-- Name: menu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu ALTER COLUMN id SET DEFAULT nextval('public.menu_id_seq'::regclass);


--
-- TOC entry 4659 (class 2604 OID 16617)
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- TOC entry 4657 (class 2604 OID 16581)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4822 (class 0 OID 16601)
-- Dependencies: 221
-- Data for Name: dropdown_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dropdown_menu (id, title, slug, parent_id, menu_order) FROM stdin;
2	Shop	/shop	\N	2
3	Men	/shop/men	2	1
4	Women	/shop/women	2	2
5	Kids	/shop/kids	2	3
6	Accessories	/shop/accessories	2	4
7	About Us	/about_us	\N	3
8	Pages	/pages	\N	4
9	FAQ	/pages/faq	8	1
10	Size Guide	/pages/sizeguide	8	2
11	Return & Exchange	/pages/returnexchange	8	3
12	Privacy Policy	pages/privacypolicy	8	4
13	Contact Us	/contactus	\N	5
1	Home	/home	\N	1
14	Fashion	/shop/fashion	2	5
15	T-Shirts	/shop/fashion/tshirt	14	1
\.


--
-- TOC entry 4818 (class 0 OID 16565)
-- Dependencies: 217
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (id, name, endpoint, children, remarks, "order") FROM stdin;
3	Men	/shop/men	\N	\N	\N
8	FAQ	/pages/FAQ	\N	\N	\N
4	Women	/shop/women	\N	\N	\N
5	Kids	/shop/kids	\N	\N	\N
9	Size Guide	/pages/sizeguide	\N	\N	\N
10	Return & Exchange	/pages/return&exchange	\N	\N	\N
11	Privacy Policy	/pages/privacypolicy	\N	\N	\N
13	Accessories	/accessories	\N	\N	\N
1	Home	/home	\N	\N	1
2	Shop	\N	3,4,5,13	\N	2
6	About	/about	\N	\N	3
7	Pages	\N	8,9,10,11	\N	4
12	Contact Us	/contactus	\N	\N	5
\.


--
-- TOC entry 4825 (class 0 OID 16614)
-- Dependencies: 224
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description, price, discount_price, image_url, category_id, stock, rating, reviews_count, created_at, updated_at) FROM stdin;
3	T Shirt for Women	Good Stuff	1000.00	1500.00	/uploads/products/tshirt.png	3	1	2.0	2	2025-06-30 01:54:19.474511	2025-06-30 01:54:19.474511
1	Classic Orange Hoodie	Soft cotton hoodie perfect for winter.	2000.00	1800.00	/uploads/products/hoodie.png	1	20	5.0	32	2025-06-26 12:20:43.157943	2025-06-26 12:20:43.157943
2	Sweatshirt for Men	Soft Cotton Elegant	3500.00	3000.00	/uploads/products/sweatshirt.png	2	54	2.0	1	2025-06-30 01:39:30.880456	2025-06-30 01:39:30.880456
5	Winter Fur Jacket	Warm fur-lined winter jacket for chilly days.	5500.00	7500.00	/uploads/products/jacket2.png	1	15	4.8	30	2025-06-30 02:00:54.98622	2025-06-30 02:00:54.98622
6	Office Shirt & Pant Combo	Formal white shirt and navy blue pant combo for office wear.	3500.00	4000.00	/uploads/products/officeshirtpant.png	2	20	4.2	12	2025-06-30 02:00:54.98622	2025-06-30 02:00:54.98622
7	Girl Hooded Jacket	Stylish hooded jacket for girls in pink color.	3200.00	4500.00	/uploads/products/girljacket.png	3	25	4.6	18	2025-06-30 02:00:54.98622	2025-06-30 02:00:54.98622
8	Classic Denim Jacket	Blue denim jacket perfect for casual outings.	4000.00	4500.00	/uploads/products/jacket.png	1	12	4.4	27	2025-06-30 02:00:54.98622	2025-06-30 02:00:54.98622
4	Leather Jacket Black	Premium quality black leather jacket for men.	5000.00	6000.00	/uploads/products/jacket1.png	1	10	4.5	22	2025-06-30 02:00:54.98622	2025-06-30 02:00:54.98622
\.


--
-- TOC entry 4820 (class 0 OID 16577)
-- Dependencies: 219
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, role) FROM stdin;
1	Zainul Abdin	mr.zainalabdin@gmail.com	zain123	\N
3	Shah	shah@gmail.com	shah	\N
2	Adnan	adnan@gmail.com	adnan	0
\.


--
-- TOC entry 4835 (class 0 OID 0)
-- Dependencies: 222
-- Name: dropdown_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dropdown_menu_id_seq', 15, true);


--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 218
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_id_seq', 13, true);


--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 223
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 8, true);


--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 220
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 4670 (class 2606 OID 16610)
-- Name: dropdown_menu dropdown_menu_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dropdown_menu
    ADD CONSTRAINT dropdown_menu_pk PRIMARY KEY (id);


--
-- TOC entry 4666 (class 2606 OID 16574)
-- Name: menu menu_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pk PRIMARY KEY (id);


--
-- TOC entry 4672 (class 2606 OID 16626)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4668 (class 2606 OID 16586)
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


-- Completed on 2025-08-28 00:33:36

--
-- PostgreSQL database dump complete
--

