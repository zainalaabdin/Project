--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-08-26 18:23:10

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
-- TOC entry 221 (class 1259 OID 16523)
-- Name: batch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.batch (
    id integer NOT NULL,
    name character varying,
    start_year character varying,
    end_year character varying,
    dept_id integer,
    remarks character varying
);


ALTER TABLE public.batch OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16526)
-- Name: batch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.batch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.batch_id_seq OWNER TO postgres;

--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 222
-- Name: batch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.batch_id_seq OWNED BY public.batch.id;


--
-- TOC entry 219 (class 1259 OID 16505)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    id integer NOT NULL,
    name character varying,
    code character varying,
    email character varying,
    phone character varying,
    faculty_id integer
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16508)
-- Name: department_dept_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_dept_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_dept_id_seq OWNER TO postgres;

--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 220
-- Name: department_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_dept_id_seq OWNED BY public.department.id;


--
-- TOC entry 217 (class 1259 OID 16455)
-- Name: faculty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculty (
    id integer NOT NULL,
    name character varying,
    remarks character varying
);


ALTER TABLE public.faculty OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16458)
-- Name: faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculty_id_seq OWNER TO postgres;

--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 218
-- Name: faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculty_id_seq OWNED BY public.faculty.id;


--
-- TOC entry 225 (class 1259 OID 16554)
-- Name: login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login (
    id integer NOT NULL,
    email character varying,
    password character varying
);


ALTER TABLE public.login OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16557)
-- Name: login_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_user_id_seq OWNER TO postgres;

--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 226
-- Name: login_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_user_id_seq OWNED BY public.login.id;


--
-- TOC entry 223 (class 1259 OID 16535)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    id integer NOT NULL,
    name character varying,
    roll_num character varying,
    email character varying,
    phone character varying,
    gender character varying,
    dob character varying,
    address character varying,
    admission_date character varying,
    remarks character varying,
    batch_id integer,
    image character varying
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16538)
-- Name: student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_id_seq OWNER TO postgres;

--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 224
-- Name: student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;


--
-- TOC entry 4663 (class 2604 OID 16527)
-- Name: batch id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch ALTER COLUMN id SET DEFAULT nextval('public.batch_id_seq'::regclass);


--
-- TOC entry 4662 (class 2604 OID 16509)
-- Name: department id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN id SET DEFAULT nextval('public.department_dept_id_seq'::regclass);


--
-- TOC entry 4661 (class 2604 OID 16459)
-- Name: faculty id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty ALTER COLUMN id SET DEFAULT nextval('public.faculty_id_seq'::regclass);


--
-- TOC entry 4665 (class 2604 OID 16558)
-- Name: login id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login ALTER COLUMN id SET DEFAULT nextval('public.login_user_id_seq'::regclass);


--
-- TOC entry 4664 (class 2604 OID 16539)
-- Name: student id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);


--
-- TOC entry 4825 (class 0 OID 16523)
-- Dependencies: 221
-- Data for Name: batch; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.batch (id, name, start_year, end_year, dept_id, remarks) FROM stdin;
1	Batch A	2025	2027	15	Studies of matter, energy and their interactions
2	BATCH C	2026	2028	21	Studies of matter, energy and their interactions
3	Batch 3	2025	2028	21	Studies of matter, energy and their interactions
4	BATCH 5	2026	2028	25	
7	Art	2026	2027	27	New Batch
8	Batch C	2028	2029	15	New Batch II
9	ABC	new ept	NEW	21	GHQNEW
11	NEW RECORD	12-06-2024	12-06-2025	21	ADDED
6	Evening Batch	2025	2027	28	
13	NEW RECORD	2025	2029	48	Version22
14	Physics Batch	2015	2016	49	null
16	Physics II	2025	2026	15	Updated
\.


--
-- TOC entry 4823 (class 0 OID 16505)
-- Dependencies: 219
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.department (id, name, code, email, phone, faculty_id) FROM stdin;
14	Information Technology	IT	it@gmail.com	7686768768	17
15	Computer Science	CS	Cs@gmail.com	98987798	22
21	Litreture	LI	li@gmailcom	8768675765	23
22	Artificail Intelligence	AI	ai@gmail.com	9786897987	26
23	Math	M	math@gmail.com	768768	32
24	Business Administation	BBA	bba@gmail.com	7868768768	38
25	LLB	llb	llb@gmail.com	876856675657	40
26	Pharmacy	Pharmacy	pharmacy@gmail.com	5435465466	41
27	Social	SC	sc@outlook.om	8768768768	42
28	English	eng	english@yahoo.com	7687687-9887	19
29	DAE	DAE	DAE@GMAIL.COM	879812-23232-2	39
30	LLM	LLM	LLM@YAHOO.COM	879909552222	40
31	Analytical	Ana	ana@gmail.com	09809890809	0
32	NEW	DEPT	NEW	90809809	0
33	NEW	NEW	NEW	34534	0
35	JHLKJH	KJHLKJHL	JKHKJHKJ	JKHKJH89797	18
37	Update English	UE112	UP@GMAIL.COM	08879998766	19
40	Update English	UE112	UP@GMAIL.COM	08879998766	26
41	Update English	UE112	UP@GMAIL.COM	08879998766	24
42	Update English	UE112	UP@GMAIL.COM	08879998766	26
43	Update English	UE112	UP@GMAIL.COM	08879998766	26
44	Update English	UE112	UP@GMAIL.COM	08879998766	22
39	Update English	UE112	UP@GMAIL.COMM	08879998766	24
47	Zain Alabdin	34345	mr.zainalabdin@gmail.com	03322691607	22
48	English	34345	mr.zainalabdin@gmail.com	9786897987	19
49	Physics	PH34	physics@gmail.com	1234567890	22
\.


--
-- TOC entry 4821 (class 0 OID 16455)
-- Dependencies: 217
-- Data for Name: faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculty (id, name, remarks) FROM stdin;
48	NEW DEPARTMENT	ADDED
53	FACULTY OF ISLAMIC	STUDEIES
19	English Literature	Studies in literature and languages
23	English	Literature and grammar lessons
24	Biology	Teaches cells and ecosystems
26	Computer Science	Focuses on software and algorithms
22	Science	Covers mechanics and thermodynamics
31	Math	Comp
32	Mathematics	Pure and applied mathematics department
35	Faculty of Science	Covers all science departments
36	Faculty of Arts	Humanities and arts subjects
37	Faculty of Engineering	Engineering programs offered
38	Faculty of Business	Business and management studies
39	Faculty of Education	Education and teaching degrees
40	Faculty of Law	Law and legal studies
41	Faculty of Medicine	Medical sciences and health studies
42	Faculty of Social Sciences	Sociology, psychology, etc.
43	Faculty of Computer Science	CS and IT-related programs
44	Faculty of Islamic Studies	Islamic studies and theology
59	NEW DATA	HELLO
60	NEW DATA	JAAAA
62	NEW DATA	KKJHJ
63	NEW DATA	KKJHJ
75	English Literature	Studies in literature and languages
77	Islamic Studies	New Batch II
78	Islamic Studies	New Batch II
79	Islamic Studies	New Batch II
80	ENGLISH	ENGLISH II
81	NEW DEPARTMENT	DEPARTMENT OF NEW
\.


--
-- TOC entry 4829 (class 0 OID 16554)
-- Dependencies: 225
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login (id, email, password) FROM stdin;
1	abc@gmail.com	$2a$10$3YB/DQ7TEgbT9OaAff7UYud2r6HTaIxP42Vd9byTZb4QOSRHJYFsa
\.


--
-- TOC entry 4827 (class 0 OID 16535)
-- Dependencies: 223
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (id, name, roll_num, email, phone, gender, dob, address, admission_date, remarks, batch_id, image) FROM stdin;
1	Shahzad	2k12	mr.kami@mail.com	03003889988	null	null	null	null	null	6	\N
2	Sarfraz Khan	2k12	mr.kami@mail.com	03003889988	null	null	null	null	null	6	\N
3	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	\N
5	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	\N
6	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	\N
9	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	{}
11	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	1749990711218-img.png
13	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	\N
12	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	1750071830156-img.png
15	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	\N
16	Sarmad Khan	2k12	mr.kami@mail.com	03003889988	Male	jlkjlkj	allama iqbal road	lkjkjlkjkjkjlkj	kjlkhljkhkhbnb,mb	6	\N
18	Zain Alabdin	2k12	mr.zainalabdin@gmail.comm	33312332311	Male	89869786	789698696	jhkjlkjhkjhlkjh	jkhlkjhljkhhl	4	\N
17	Zain Alabdin	2k12	mr.zainalabdin@gmail.comm	033312332311	Male	76-08-985	UNIT 6 LATIFABAD HYDERABAD SINDH	7777-06-0798	new	1	\N
19	Zain Alabdin	2k12	mr.zainalabdin@gmail.com	98798798	Male	897988979	UNIT 6 LATIFABAD HYDERABAD SINDHjj	lkjkj;lkj	kjll;kj;klj;lkj	13	\N
\.


--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 222
-- Name: batch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.batch_id_seq', 16, true);


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 220
-- Name: department_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_dept_id_seq', 49, true);


--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 218
-- Name: faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculty_id_seq', 83, true);


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 226
-- Name: login_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_user_id_seq', 1, true);


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 224
-- Name: student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_id_seq', 19, true);


--
-- TOC entry 4671 (class 2606 OID 16532)
-- Name: batch batch_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.batch
    ADD CONSTRAINT batch_pk PRIMARY KEY (id);


--
-- TOC entry 4669 (class 2606 OID 16514)
-- Name: department department_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pk PRIMARY KEY (id);


--
-- TOC entry 4667 (class 2606 OID 16464)
-- Name: faculty faculty_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pk PRIMARY KEY (id);


--
-- TOC entry 4674 (class 2606 OID 16544)
-- Name: student student_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pk PRIMARY KEY (id);


--
-- TOC entry 4672 (class 1259 OID 16548)
-- Name: student_batch_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX student_batch_id_idx ON public.student USING btree (batch_id);


--
-- TOC entry 4675 (class 2606 OID 16549)
-- Name: student student_batch_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_batch_fk FOREIGN KEY (batch_id) REFERENCES public.batch(id);


-- Completed on 2025-08-26 18:23:10

--
-- PostgreSQL database dump complete
--

